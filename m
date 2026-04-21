Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80441372675
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799108; cv=fail; b=sBtR+uTG9mVn6UQuBoumnAiSvQnfcJ72k9xtbfUFswBNEgp0d18o4uUTq/Kcz/MqvX/5cjBFSXw2XESDbPP6xyjkDzO2jnM/aTZLoYdb0zURCpy9q8IYdCaP75ybSLWtW3QZ9YGr6PjbAGxja8R+eomO43gCp/I2tDcm73gzrvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799108; c=relaxed/simple;
	bh=rEmA+DyRj48768zYyPgQBWW+c7jNjo9ht1p60k0dzVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OHkiSy3e8hG+CPnvxAcIvpk/q/gkjU6XLoxn+q13sdfzJfNSfcFpyxcwTLmBKeNWka0PmF/Ftnx3raU33P1ETLdaB4GgxaqubC68dqZcpIjrTdgV76uK3UQphOnLZBDTEIVazcO8nFZLFENM+5qa5pmtIn4JG1ux8A3K7CGmn1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uv+Ia2pr; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uv+Ia2pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776799106; x=1808335106;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rEmA+DyRj48768zYyPgQBWW+c7jNjo9ht1p60k0dzVM=;
  b=Uv+Ia2prSaTMyLlI9XbUI9wEtQnpjvP4I8b+O+6xZUvLI1pmr2Cl39n5
   fwJwVmEcSXeY7T5R3Mj1oLCaCerT1YDjDQmW9cBl6vFan6yabSn34Lo40
   3zqUGT/32TkWfEPTQWgJuXkKM+tBJaQcFjpoCl5yxe2jxBikdmpqaiW7b
   kpeWMCVOAPMoP6QjCoG0s2Q2vQoRwJ2M1Lr24pK3AMDopE82d90RTBUXR
   FywFt/BHO8lJQvxzmR59TFhDogC+7tmYuDOqHqnRAQO00mg3oY9vAzRcg
   HjVmtThkeVHr09JYer8S2W7o7gdHrHSHgf55+nREC4wFQKwWYJrhlvCpZ
   w==;
X-CSE-ConnectionGUID: e1K07AseQ5GRBazDmmtnhA==
X-CSE-MsgGUID: 3gdqoOv8R6uL0QDQAlmX4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81358007"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81358007"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 12:18:26 -0700
X-CSE-ConnectionGUID: bBe6aDTUQXW44Y2Sk0slxQ==
X-CSE-MsgGUID: jtAxm5xHTXCGGRkrlukHMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="237152242"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 12:18:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 12:18:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 12:18:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 12:18:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwH2DebNlSgueeFwaCqOw/OoPj48zm6qFUm/fNudv63TsT5nVCM1PnxxN9p1HRVVmyQRjK7TqIS9ye3cHA3duOQIX4xi6HjmX1n2VwQjNG6WF86liDav7HvsvNcQ4utN/v8nzeXrbvStnBb0NW0WtV9gEY9BVwBxQ00zUZH7LDp4ioyui/+GJt+ZLqLKbqrBTvdd6Mn3ibu0OUtnCGkYJ9YZZPOyTZaf3vma3u3K6q85joa2EjL6RCF5kuN6JhnTPRCCEY6XR5ozYdsHHE7/SZu0bX9Ihtkw02Ry/JhLL++vCYSt3WmOvJpZ3+GJ6MncSXzOKMmpGsYHvwy0Ha8DSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEmA+DyRj48768zYyPgQBWW+c7jNjo9ht1p60k0dzVM=;
 b=NtV+G8BrU5zBcPfh/JrpXCbQlx2N7A74VZpqRwyIkckWEIR/evTd1OJ93isehypUeqUiYCZw3KwGpGVb5a+uUquprlq8oOp6KNuxBuJSKaGghZgnBd8rkNMdAqd4mTQL8o7U85xI7gVnGtunnQNYBK8b4SJj5DH8OlnkN6e7hBMGmfGX8eEIK5325lJi5NSawEhfZZ7TnHT4YgNtQxuAD6hU5OEwnRSDJQ1/ZbSiEaYcwuBUN3GLlIqSd9vF/Za3WWbXdTGbWYoic26FtYbXf+QfnbMkZ11OIl36jUopVA+7/dER23eZro0veJSEr5bdUmloIz8UQklSWOkSiKTvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DSWPR11MB9584.namprd11.prod.outlook.com (2603:10b6:8:36e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 19:18:22 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%5]) with mapi id 15.20.9846.011; Tue, 21 Apr 2026
 19:18:21 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "tglx@kernel.org"
	<tglx@kernel.org>
CC: "Wu, Binbin" <binbin.wu@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "bonzini@redhat.com" <bonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Topic: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Index: AQHczeKk+wS46Li00UqCaHMewgV8CLXoEP2AgADoVICAAC7QAIAAPWUAgAADsgCAAACJgIAABFgAgABZ2oCAACOCAA==
Date: Tue, 21 Apr 2026 19:18:21 +0000
Message-ID: <819b1ab82054ee4f08a64961b13e4fb433eaa62e.camel@intel.com>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
	 <87mryxekxy.ffs@tglx>
	 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
	 <87eck8daot.ffs@tglx>
	 <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
	 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
	 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
	 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
	 <87cxzsb5n0.ffs@tglx>
In-Reply-To: <87cxzsb5n0.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DSWPR11MB9584:EE_
x-ms-office365-filtering-correlation-id: fa86120a-a85a-417d-6890-08de9fdac0ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 7Wxf3rynO3YqjhvGyermaxaqIOVsO4lroy6qQ+TU59J48wO7iojwvmOD66GsUo1B/XiK7gaz3Nve/bSykiUfqmO0/cnmjmbR4tUP+a7XcV5sF8AtSqKVKEq5n84wQnnhewUFvp+lE1F5U+aJfL1/iUaM6MXYrCV8WIITs/N/2KiPsoVPsFvyTYnqxG+l+oduXJhWY3+vRw2TtVZ6jzQf6mQZyVHLdhJpUyXqHnDiiUluVqDQbyup3W7glNSt9MmM0OeFPbSuzog2xcNdHQrlUy3dDyI15PNEaHWuYEoI5l7G8vR/wdICY0yWaRn83QMoH2jCpVVRu+gU4+Lf4Ede1t9RlhBgmI+fI/09ZYOfSaIuFa3zsa4cy69t7Ybv1qrRxkOsfM2j0SaIYXc1o2l4z3cFwWm+vaFmfFqdauTQMjgGOdydXe09sqBJ8yYn3B8uczzgVp8wWiqhxr8ifS9FlPWLpfFgIb0PxAuB+62mg01TAv/UARkMmb0m967hcEcBIpV5SATC9mx6c0IqduSIAihyrCGYpu/mUatWlsHSGa+umnIfSoU+6diJClNcKIQk9N17v1/jl9SvMi6ynzHy4MUD+rCIHxurj9pcdDllJap4p6oGlPjOhG99keKnR86RmFxaFWf7laGsu5ruLF7ojU3QJDz9KsF9gGwhcA2GOH8UgSckqI+Flouf6h2g+AGkc7O/tORr36b8gmyG3qqPyOffbdb28BlsIyv7F2wgjxVKUpVQ9Hb8syx5AQV+8DdHTvEa1LxfWK1B9/URZl+xXSfdEyja4SRw9HVOHdQHGDg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlIxbmxiL0pOeTltVVlsUmhyTE5ZRGw5QkFQQ2ZJTytPWFhLdy9YMXloQVNB?=
 =?utf-8?B?NWlBZ1JLVlZUME43bFVGOWhUWG5XZDlTWjZZOE5Ba0VPcy9kWlNIZUFqZzl6?=
 =?utf-8?B?WjZJUnlqNFdWRW9RdlJJdXhvc1V3aUZLQWN0SzhZQXJXMlc0cmVZV3BDZEFw?=
 =?utf-8?B?UmVVaGswcGJydmFtRXU2NzJ5bFBPK3BpM2VnYWxwSmx0SG8wUnlOc3NaTWdT?=
 =?utf-8?B?engyV3dkVHFMcVhzUW1kbmJtWFRQa3ZXT3pwTmtoMmV5RFl4NVRxeEdNZ3Jh?=
 =?utf-8?B?clVCT0ZvekIrL0d2WndIQlRuVU1Ib21KM00xcGtKdnlvY3hQUWdnMFNMTUwy?=
 =?utf-8?B?RHdLUlcyY1ZNTjNDckpRR2c5ZnpjeW9SaHZiK2NKNDRTTnZWWDlTU2F0blU2?=
 =?utf-8?B?c2hNVGtHK0FwT3doRm5NM0ZOOHdwUDZjRitJUWZjOStkN1FONlowSStTMTNl?=
 =?utf-8?B?bmdsVUVJS29lYXNucCtEY24rK3J1K3BPR1ZUcVNmcDJOV0pxWWpoMWNQZSto?=
 =?utf-8?B?OXV3Qld4QS8vTzJoZ3NlYUtCUVBNZHZvU0gvVHZWR3pzTVRRNTdQbmQ2dWN4?=
 =?utf-8?B?ZjJnVXdMNW1QMTJ1Ujd1cmY1eDgxZFJPOVZidFYvZWpCVWxsT0hDS0Rwb3RZ?=
 =?utf-8?B?ajM5VDhMM09JRmFhb3J2bkpFUXd6dHlGeXZodVNsUXFZL2VjdzhtR2w3UzE5?=
 =?utf-8?B?S1lId0ZFTy9XR2t4TXFjNWpCWmZ0RlJTcXlFYkZtVlBCZzV5NlQvRjA4TGo2?=
 =?utf-8?B?K2J4UndYZEU1ZHVTMXFoZFVMWjgwbXptWVRYc3hKajZUOVNHRllabVJHdThh?=
 =?utf-8?B?YnVrbzFqSEtrVGNoNjRSaW5aV2hDRUFldG5ZU1N4Y2g3YTNHWEZ4RjNCUGhm?=
 =?utf-8?B?YVMreFVPQ3U4TlpLVVA4b21RZkgwOTBQdGJJaWdvUXlNcFpmWjFyZHR1ZWdL?=
 =?utf-8?B?UHRCNVZ5VEJPSGVxcWJQekFQeVhlZDJScU52YkxsZ2FMazdKN2lOSXhtQWxJ?=
 =?utf-8?B?VGh5UmlOTWVqOTB3ZkhiQWxuRjBlTnVuRnBLVWJ5aktjR2hRdVBkSXNqQWtu?=
 =?utf-8?B?SkY3SkhYTDkrMllVTGdBNEtIajBSZWF0U0ZyenlOZVk4MFJ0Y1hyRTRncTFE?=
 =?utf-8?B?aWhJWTJRR0wyT2R4dFhJK0FONTEyaFRnNkJ3MVQzY3plTFExcFI1TGFLVk1W?=
 =?utf-8?B?MjhmbkQyUGRBVmZybTYwU1drVzFacjRBV2MycmE3OXZPckUweXFnQ09RUkF5?=
 =?utf-8?B?Y2lRajMvMXJvQzJZKzUvNlJSY1FMaEZyd1VWOXF6VjFkT1loalNMczM1TkFF?=
 =?utf-8?B?TWxUSWtGZ1UrdkNTd0g1b0FwZDhxRnBxNEVzeTdNTTV5bytVczF4Yk1kZitt?=
 =?utf-8?B?d1VoZlNsdFdrUHdCd21sWWZpSXZrRG9jMTFWRFhoVzVrTWhxNUxiallEdnY0?=
 =?utf-8?B?VlpocCtBdEVpM0hqdDhBR1lXQk96Q0F6b2ZZdWlwVm9UUWtkdVB1ODZYMDg4?=
 =?utf-8?B?NmFNNlljckUvb1FMbW5jcXhLc2xUaHJZZDJMZVYweGFKRlA5TnZIdlpsMml0?=
 =?utf-8?B?K1pTcE94eXpHMU5ZVlFjbVQvRVRZV3hidlJGWTJDRnlJaUl6OHdlZVJUTWk2?=
 =?utf-8?B?UjE3bWZGSHJzVTRieEE3ZFVYaEZzaUlRK05DTS91Y0FaSzg0OXlmdExTQlRa?=
 =?utf-8?B?OTMrWDZQaEpYenVCQ1VsaStwQWFQYW8veFZteG41d2xld0RwZW5WQnRtVWN6?=
 =?utf-8?B?Y3dQU2x0bzdHekh4bTZldHU4ODlKNzArOXZwZ1IydkI1SmNEc3lGYmQvUHJl?=
 =?utf-8?B?RXFMTkhHbGNmOVRyRkx4NThRL1M3SEc0a3RWSkJhMGQvaFduQ2k0a25pSHFk?=
 =?utf-8?B?dnVPTEwvZXd6RmlQeGdHcXJ0TWE5WWNjeU1BMGEvQ1JqNUpZRGUyODJ5UkRY?=
 =?utf-8?B?dFVTL2c0cytVQzBMMnpyMXlrQ0xwVFd5UTY4d2FLM0NaeDRlVFNERUVnVkQv?=
 =?utf-8?B?QlVTN2ZabktuUTVvM3ozbFNZMVZyQ0kyajZER0svQStqemZzTHNua2txSk1h?=
 =?utf-8?B?M0dTQXNLQXZwYTFxSmFkWC9kTkMwSStXTytDb3RWRE9DNlRLR3dPYnhHVWRi?=
 =?utf-8?B?RE9oM0pkNmpjT1VQS3NaZnhqMVh1RkxCemY5R2RteGdENjYvZ1o5Rlg2ZHFn?=
 =?utf-8?B?bERUdUtVL1NJNjRaYVo5Q1JaSEZEV2dPYmExVW4rNmRtTDZINzZXVEFXbzNE?=
 =?utf-8?B?bW03YmgwYW1uUVAyWHJZelFLa2oxSWNKWmlFM3FiU284d3VBV0ozS3hPZlQ4?=
 =?utf-8?B?R1lpWGJLYUhTRUV3VEladTZKTW16a3g1YkwxdmRVMVNYZFBQSU5IdmVDTGVm?=
 =?utf-8?Q?Ey3DZm9UdBiQM74k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA80FFC4FA21904C8CE2853A9FB3922F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vNg8VuCxzhR3Vlw6y9SBxIptSwuHfyztU/dPeXL/idmBVlDKb/5n6CXXtzfxPS8rgPwF+mtsX+eCsuEzyaf3tuARoIGjpvxmRVqKqFY7fDzNevVDhL/5fQgF5Hd3YRZ1zvx47hwG01gmGmHpfKZEf+QHjDAIjJMNEPi5vj8kKUSQghlbwnWbfshsE5wIZvxrCGsgpIsl5cmN6O+z1NtwC/Fk/YLWy6+iZgMDLuMhlYsJ1c/zxLiMYsNf+5r2s1nxrwJEwf2DEr+ClEPY9eWANbAFWuKb91bYwTIDDAT0tDBsBc7mWYMGRrHMmzfED1oAP/dJmd0IWGUwIgKjEvOoUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa86120a-a85a-417d-6890-08de9fdac0ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 19:18:21.8779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: euJ9xVrv9W3k+2ibK6+JcpcjivQOPeDQIh7V55YyJRRforwE2u0V3zaGODmRmZYALpMRKdMQSdkfrNXyATaOL1q2RJ5FyhgGx4nMRELNUmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9584
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDE5OjExICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiBOb3cgZm9yIFZNWCwgdGhhdCBocnRpbWVyX3JlYXJtX2RlZmVycmVkKCkgY2FsbCBz
aG91bGQgcmVhbGx5IGdvIGludG8NCj4gaGFuZGxlX2V4dGVybmFsX2ludGVycnVwdF9pcnFvZmYo
KSwgd2hpY2ggaW4gdHVybiByZXF1aXJlcyB0byBleHBvcnQNCj4gX19ocnRpbWVyX3JlYXJtX2Rl
ZmVycmVkKCkuDQo+IA0KPiBCdXQgd2UgY2FuIGF2b2lkIHRoYXQgYWxsdG9nZXRoZXIuIFNvbWV0
aGluZyBsaWtlIHRoZSB1bnRlc3RlZCBiZWxvdy4NCg0KVGVzdGVkIHdpdGggdGhlIGJlbG93IHBh
dGNoIGFuZCB0aGUgdGVzdHMgcGFzcyB3aXRoIHRoaXMgdG9vLg0KDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiDCoMKgwqDCoMKgwqDCoCB0Z2x4DQo+IC0tLQ0KPiAtLS0gYS9rZXJuZWwvdGltZS9ocnRp
bWVyLmMNCj4gKysrIGIva2VybmVsL3RpbWUvaHJ0aW1lci5jDQo+IEBAIC00Miw5ICs0MiwxMCBA
QA0KPiDCoCNpbmNsdWRlIDxsaW51eC90aW1lci5oPg0KPiDCoCNpbmNsdWRlIDxsaW51eC9mcmVl
emVyLmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L2NvbXBhdC5oPg0KPiAtDQo+IMKgI2luY2x1ZGUg
PGxpbnV4L3VhY2Nlc3MuaD4NCj4gwqANCj4gKyNpbmNsdWRlIDxhc20vaXJxX3JlZ3MuaD4NCj4g
Kw0KPiDCoCNpbmNsdWRlIDx0cmFjZS9ldmVudHMvdGltZXIuaD4NCj4gwqANCj4gwqAjaW5jbHVk
ZSAidGljay1pbnRlcm5hbC5oIg0KPiBAQCAtMjA2MiwxMSArMjA2MywxNiBAQCB2b2lkIF9faHJ0
aW1lcl9yZWFybV9kZWZlcnJlZCh2b2lkKQ0KPiDCoHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9p
ZA0KPiDCoGhydGltZXJfaW50ZXJydXB0X3JlYXJtKHN0cnVjdCBocnRpbWVyX2NwdV9iYXNlICpj
cHVfYmFzZSwga3RpbWVfdCBleHBpcmVzX25leHQpDQo+IMKgew0KPiAtCS8qIGhydGltZXJfaW50
ZXJydXB0KCkganVzdCByZS1ldmFsdWF0ZWQgdGhlIGZpcnN0IGV4cGlyaW5nIHRpbWVyICovDQo+
IC0JY3B1X2Jhc2UtPmRlZmVycmVkX25lZWRzX3VwZGF0ZSA9IGZhbHNlOw0KPiAtCS8qIENhY2hl
IHRoZSBleHBpcnkgdGltZSAqLw0KPiAtCWNwdV9iYXNlLT5kZWZlcnJlZF9leHBpcmVzX25leHQg
PSBleHBpcmVzX25leHQ7DQo+IC0Jc2V0X3RocmVhZF9mbGFnKFRJRl9IUlRJTUVSX1JFQVJNKTsN
Cj4gKwkvKiBMaWVzLCBkYW1uZWQgbGllcyBhbmQgdmlydCAqLw0KPiArCWlmIChsaWtlbHkoIXJl
Z3NfaXJxc19kaXNhYmxlZChnZXRfaXJxX3JlZ3MoKSkpKSB7DQo+ICsJCS8qIGhydGltZXJfaW50
ZXJydXB0KCkganVzdCByZS1ldmFsdWF0ZWQgdGhlIGZpcnN0IGV4cGlyaW5nIHRpbWVyICovDQo+
ICsJCWNwdV9iYXNlLT5kZWZlcnJlZF9uZWVkc191cGRhdGUgPSBmYWxzZTsNCj4gKwkJLyogQ2Fj
aGUgdGhlIGV4cGlyeSB0aW1lICovDQo+ICsJCWNwdV9iYXNlLT5kZWZlcnJlZF9leHBpcmVzX25l
eHQgPSBleHBpcmVzX25leHQ7DQo+ICsJCXNldF90aHJlYWRfZmxhZyhUSUZfSFJUSU1FUl9SRUFS
TSk7DQo+ICsJfSBlbHNlIHsNCj4gKwkJaHJ0aW1lcl9yZWFybShjcHVfYmFzZSwgZXhwaXJlc19u
ZXh0LCBmYWxzZSk7DQo+ICsJfQ0KPiDCoH0NCj4gwqAjZWxzZcKgIC8qIENPTkZJR19IUlRJTUVS
X1JFQVJNX0RFRkVSUkVEICovDQo+IMKgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkDQo+IA0K
