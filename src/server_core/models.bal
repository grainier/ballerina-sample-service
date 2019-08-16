public type Files record {
    string product_name;
    string base_version;
    string tag;
    string filepath;
    string filename;
    string extension;
};

public type Products record {
    string product_name;
    string product_version;
    string tag;
    string download_path_param;
    string kernel_version;
    boolean wum_supported;
    string long_name;
    string keywords;
    string md5;
    int released_date;	// timestamp??
};

public type UpdateList record {
    string update_no;
    string platform_version;
    string product_name;
    string base_version;
    string tag;
    string files_added;
    string files_modified;
    string files_removed;
};

public type ChannelProductversion record {
  int id;
  string name;
  string description;
  string product_name;
  string product_version;
  string 'type;
  boolean globally_accessible;
  boolean globally_visible;
  string filter_rule;
  boolean default_channel;
  boolean latest_product;
};

public type SubscriptionChannel record {
  string subscription_code;
  int channel_id;
};

public type Field record {
  int id;
  string name;
  boolean optional;
};

public type ProjectCategory record {
  int id;
  string name;
  boolean allowed;
  string description;
};

public type Rule record {
  int id;
  int field_id;
  string name;
  string condition; // enum
  string value;
  string message;
};

public type SecurityAdvisories record {
  string id;
  string overview;
  string severity;
  string description;
  string impact;
  string solution;
  string notes;
  string credits;
};

public type Updates record {
  int id;
  string update_no;
  int timestamp;
  string kernel_version;
  string platform_version;
  string platform_name;
  string filename;
  string product_name;
  string product_version;
  string md5_sum;
  string update_type;
  string description;
  string instructions;
  string applies_to;
  string bug_fixes;
  string files_added;
  string files_removed;
  string files_modified;
  string lifecycle_state;
  string security_advisory_id;
  string tag_branch;
  string tag_issue_type;
};

public type Versions record {
  string 'version;
  boolean is_compatible;
  int released_date;
};
