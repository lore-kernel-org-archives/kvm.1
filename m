Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5F3B2D18;
	Thu, 15 Oct 2026 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087999; cv=fail; b=bfq3ulR8nTV/fDLik+upwpxx37D7MDkMeeo2xJhS60SP2VzLGvjOu0F0S7MvYSfl/xvmfGIPnjprx69tcYpnXj+KFa7513JHYLEHreQXzgVewm2ItUdX6eFYe0hp6xk8uFDZ1WmW0ZQdj9fcNy1fZ0T9W50LKgc1Ovep/LVx3Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087999; c=relaxed/simple;
	bh=aJ5Y1sMk1kCsuF1/5MNm2O1nF/VYyi87nU4Vb/Z552s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qszjEIZB+L7eodrr67CCX8gs89WsMg7aExsjrh6xRgXuUaBnJfU8Pf0ZTRQcs5oSYK77MwzTS4IhR0SiAkZR7sSTRuwLPxYNRN0WgUnUQjuu5tV6o+8m8icwMlaithhHhm0B3fzXaDhGBCoAugIgZ+zkoQVlLyhGjYufvWu31Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fz92fbY3; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fz92fbY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792087993; x=1823623993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aJ5Y1sMk1kCsuF1/5MNm2O1nF/VYyi87nU4Vb/Z552s=;
  b=fz92fbY3BUoBZwcMx8Fh73Roo1uCPnJnkWNKBBbFfm1HyGDwQOw8Hbce
   0hJtRNQ2VesdAyq3i856ysZ3s3J2kYR+qVOoDasGBKuyXbGbn71dBlspj
   DHY/lXDYQ6sJvJVSNzjLEASMFPnqTPDGnHX/Fvw4MWlt6ubOR6irAXndS
   kC1ua3WlNpDG415O+Ovv8Axqo/9rumtPHBkX4NQCUN2EiXb4hrbU7lfwg
   8FI04zkv7IWczdG6UgD7QPg0g1RK+onmzn/feM82vh6Z/HEJuJAEf0xEg
   EFrbV7MPinTaln0E5RD7JNw/v0/IH4ALoLVAr0NnV6Pnh+c+pCSi5bCui
   w==;
X-CSE-ConnectionGUID: s7BfZ/cOSG6AHtfz5gPXOQ==
X-CSE-MsgGUID: bJby+SqFTKqfivZJhPSmjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="870519"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="870519"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:12:11 -0700
X-CSE-ConnectionGUID: BKaSA+Q0RImma3RSKZaeiw==
X-CSE-MsgGUID: RjKISskqSaWp/bf6H4T/yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1687559"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:12:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 11:12:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 11:12:09 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 11:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1Vnjsz3GceGNa1bN3dFMyWW4i94Vc+/LIKHhUe2SYS+w9o7A45ySSEHrp+hn5aJFasL6sHAeYlMXbHmZZcg6zSAZcoBBCKkboB7eDkC8ZkFH6NCU1RtMl0qXC71Jt0t5Nxwo/oGF+LcxeNFc+lxJAd7I4nMmQ32KJaM0tw7SRNfilbxNPugow2D3BhZRuwvRcXFseSrnc87U66cXsHMCePCFNpJ/ifODBiqhyx1vk5qrHJ3astFc4XQib71ag+fp9CuilqOoXmzNXnNqyev1PS2T4GeGJKGs3bGOHzpD8PM4Z9tUEbzqs0NOZ5yx8Y+fgidlFizhnOjW3XBj0gJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ5Y1sMk1kCsuF1/5MNm2O1nF/VYyi87nU4Vb/Z552s=;
 b=I8iagXwWdD5MHAYUtJmMDcbIH3Xt28bzHE9MIiXCi+/+OgDHAUjQf45tEe+aTLB2uB6DIWZNKHjU0atA5WhL9R00Oa5ZE8j7lt4yPLKXzG8CMrXI08DQSCH2tTNZ5LXPM4sYT8IxyqlZCuUkPG3BbrlMVASrlXSsxas4MAGdowqVKC4sBN9gUqkfFTRHKSQ4IFZW9rJ/9hYkxccQJ4wExwJ5tlkRYaI2aIPil0EAZ29hAEiArUOVl0qc99JlkyCl2S6Mk0QKKq62aY0dmVaTbX/z7eZ5y2VyFJZtjTBHHiYAtV1d50NulXk7ZAFE4PTGj2TqXzraGY53advyVVsFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MN7PR11MB387314.namprd11.prod.outlook.com (2603:10b6:208:5ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 18:11:45 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 18:11:45 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "tabba@google.com" <tabba@google.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org" <david@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Thread-Topic: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to
 support huge pages
Thread-Index: AQHdTykCb/i0a5FVc0eZkBiALVPvabbpU5eAgA1PggCAA/5+AIADbkMAgADzGAA=
Date: Thu, 15 Oct 2026 18:11:45 +0000
Message-ID: <896585225b67cb215db0ce66dece20ba8fbb919f.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928090808.15484-1-yan.y.zhao@intel.com>
	 <e494996660b45273590860e961b36378c4099c03.camel@intel.com>
	 <asoQ/P7sghrEVDQs@yzhao56-desk.sh.intel.com>
	 <ea3584fd5613223ee066fbd368272dc7070bceec.camel@intel.com>
	 <atBLdGBCsPwMK7Sh@yzhao56-desk.sh.intel.com>
In-Reply-To: <atBLdGBCsPwMK7Sh@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MN7PR11MB387314:EE_
x-ms-office365-filtering-correlation-id: 18338ee6-e550-4f86-82a8-08df2ae7c60f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|10067099003|22082099003|18002099003|5023799004|11063799006|261009223027099003|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: EtBNVo63B3pgJTf1Qi8jdZUZ2ln/eGZgMsSxoTC/vbHhvU9U3Du+zazQFTryYMEKzylgs8UL2OhIVCvzMDIkPvL6S/7ViQJu3vpS6r32hZMDKtAnSPhUcS1KJZfCyEYDQsMPdK173v3b3UVErkxjpSWJvJCOPqHthmnpZwwJUREaR0vnWZZy5Bs9zpgvAoE6JyN/6Bc79WVAX8XIQiIiS3TLCxEHP8ZqOQAm9wwVBCUg3/29fdmxC1i9Mc/GQL+aYf/gKqtVCoy79awj9dIiRJDBnBB3qGpbpyHSrOmPjyMyDh/nt3wmAqwZ+kuy0htfCBMrygNcxf75aibWZoz4M6PPnKcedwsX2dcClS4AmH9dLVslgC4i55lCDiLUfi8HA6QC9Mh/1kpBpApUfRIsSPQ/bHCaUuTLX4fAhhNdBQF5xkhLz+4JQ3HqugBFInDXu5FNWdT9gbPtz7YCC36CfLH5wEg2orwBDr7cMuF0YuCZbboaSNRNcYqSd1K8wKrUylK33WFZ+jd95lxuKMH5w3iaSL+tvlWcZQ7up2o4+c737sA3XR0b2A47zo7P500KLZy4M0B+iNH9Pz6NEgNWVABqHFMWWSGW62dwYweYsdngXJl0mitO8CfSbIWUN5zCdpm98MMwjnuefIDm6aC4NMguGllVuxqoGLVkot1hhoqlsWLqFPU6FKwqlWHoBBRqt2qbxYLUWyQedpb1k40sqcMasHAmGVg3odDc0T3eDRg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(5023799004)(11063799006)(261009223027099003)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWtqeWRLUEl1eHVDN3l1NWU4dTVWeGVFNnJnVE90dzREQ092NUNXRFA3N0c1?=
 =?utf-8?B?MEwrdHJnTG9tYUp6a25ibTFTSTFHb0hQcVJVczZpazFVWG5YSUJFY1Fud212?=
 =?utf-8?B?Y29yc21LR2VETUlBeTlWVURsTGU0emVSelpKdXlPRUUwZ3NEVjBSbnQ5SWE0?=
 =?utf-8?B?ZEp1UFpYZlBVLzRiTlFwd3I0WmlRQ1dhbVB4c3UvNDhzenR1Q2M4UU9VTUs5?=
 =?utf-8?B?WFJiajh3UmVBQjk3RGIvSTFBS1gvN0FjZC9YZ1pzN2hTUXE0MjdUSHgzV281?=
 =?utf-8?B?RnN3RzJ4YysxZUE3Nk5yL0o0bUFKNlNidEIxcTJqT0d4ZDZHMCtIM25Oa244?=
 =?utf-8?B?TXpEcWNxNld5VHFSc1REWGs5NzRyQjRTdTlrWmpBamM3TDZ3eVlPLzFkRXRR?=
 =?utf-8?B?bUtyK1pPOTBUSzFvNWpQWXBWMTdZTElZbGZZWXVDOEk0TkdKKzNKRC82aXpn?=
 =?utf-8?B?MS85OVRZNkRlekFDbzA4dWZYNnhiWkFVaTIwdndsR0czQ3lEeXNLcThXdnN1?=
 =?utf-8?B?OW0zVkRia2RxUDRsa1ZoRzBwTmorMmFtUFBQNW1TRklNaWpZR0Voc2JZbXpK?=
 =?utf-8?B?M1hnZVE4N05veVUxeERkUzRSWmZhdk40ckJ3OEMzSFgreUl0aDNZQWNHRHMz?=
 =?utf-8?B?QnhzWnNobW02Lzg2NVorUDVSVXI3Y3phWWNDWXBFK1VIODdiQXl3a21taTVK?=
 =?utf-8?B?SVczWXE1SlpUY3VvNCtEaUFhamt2eW9Xa2xaZlA4d25FRE9RejlwTEVIWGZB?=
 =?utf-8?B?L3BIN29aNHFJdkxCZmlYY0hGYmsvc2ZNOHVwSnZNM0cwYXJKWVN2U1dEZ3U5?=
 =?utf-8?B?SlBmNlBmNmVhOC9VcFRCQ0plU1NEcmp3S05jOHpqRnVkVzNOMHpmVFpxMDhC?=
 =?utf-8?B?a1l0VkJ4SmwzUTJCblZDVWExTk05NUV3QXgzRHhJRE1HSFljY29Ha2t4dzVQ?=
 =?utf-8?B?UXYzVG9MSjdWekdpRnUvdU5xYUkwbnlJTlRPUUhQUW1ZY0l2Q3JienByNTBx?=
 =?utf-8?B?M2pTemN6VU5TSTA1NjFrWkdjV0djR2RFQkRBbENCbzNRWmFodGdhV2VhUHAx?=
 =?utf-8?B?NFhla1VrMmh1aXJEcWVTSzduekpuQWs5cTdzMG0xSDVXT0tFT2ZBSldvb1Bk?=
 =?utf-8?B?TmVsTTlDMldZb1d3N25nOVI3dXVwSy9CWjcwMElHcXdPekFaVGl6OTMvMVRJ?=
 =?utf-8?B?YTVwUExxWG9NYWs5Q2JTenJ3VURxOHVEOS9QOVljZW1xb3d5UmdqSlROVVhE?=
 =?utf-8?B?dVRQb0VEUkFCRWkwRGVnZzFlMjhDU1lJQ0JnVloxV3pDUlBGSnYxcjdHL05V?=
 =?utf-8?B?eFU1dDVqVWp6MU1yNlF3dzlnZFZoQVBmay9DYlBYekROdWxOODJqelIrK1BN?=
 =?utf-8?B?dmlvUk5zTHhJMWpLQmI0UitxYnU0a2dLemhhVGdvWHpabUIrOUh5REJ4REYx?=
 =?utf-8?B?Sm82VW10TlJkcTdxNWt2ZXZJeGEvMFRzT2t2bTBEUTJkdnpjMTVrMmtMRE5H?=
 =?utf-8?B?b1JxcS9OVi9lMFV4WGRJTmxGMTVCVWt6UGNWSmZSTjB2VUxuNVdwc3NmVGha?=
 =?utf-8?B?KzIxdXVZNlNneGdGUENtQjlXTmtDVjNQbEE4eDdqTk9lOTNKNnBsbU1xTVBl?=
 =?utf-8?B?MXZ2czUrMEFIRHB1Z1ByN3B1TTNxWUhpSmxYaGNsR1dMdFlVOGJrZWsweDM2?=
 =?utf-8?B?blplanpyOE9jRDNhcDhsZTBRcEJpdUNVRW10U0pCRnFVZFgwbnl3dHAxTnZr?=
 =?utf-8?B?Z0RKdVZhQ0ZtYisvd1RSZnRDbStNSW9JNDhtbTE2clJnNzZkUFhFZFlDMjg1?=
 =?utf-8?B?WHN3Vk9NU1FCcHl5QXdPNGVlK0hxS2o2NGdiWjlDT014cDBmSXZrem93TERC?=
 =?utf-8?B?VkRkTkJZUXRmMjE4MDVvdlMrU0VoZUVZb054L1lhbHFlSjVOd2c3bFZrVXFJ?=
 =?utf-8?B?bEUyV1VYT1A4QTdLKzZKNDgzV0RaVkRObDZnQXVQTEZJc1NxSFdGdzFiZkdl?=
 =?utf-8?B?ZGs3U1MrbFI4UmhDUDIvTHVjTW9FNFdreGtRQWFGMmNRczZWdUN2RkpwR0pF?=
 =?utf-8?B?VGVZbUN2OEVaUzJZUlhBcVdwSm1NQmpVY3VsTTV6T3JZU0M1bHNtdmVOTm1Y?=
 =?utf-8?B?OTdSSHJ1L3RTQnVqMnVXT3BCTE5HRFZOMmFleU1lWFdUT2YyMXZ4U2EzU0RM?=
 =?utf-8?B?Y2drd0xpK2p4b3VxRTBLTnJEdjg5blVQZUZwWjRaWVByNEF4eGIwSzlBdXRn?=
 =?utf-8?B?ZjBDNGJMbVBiMmRuSXNwczROWkw2c2lZN0JDUC8xNlJrdENjWm9XWmNZODlx?=
 =?utf-8?B?aEVFaVo2N2hja25YYll2VVRjeEtRNjNOd29vV01tTldkRjlCSkVNcFhYemtq?=
 =?utf-8?Q?4WP9JQsKgKM/3/jQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51248ACDC33D3C4A860631E9ADAA5AF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RpkxDVv6Vz27aqCxXvOIn8SFLfnI8brwtGAA7NIPI1Z7t7btaC/WkknQzJfN/jiaEFwSx9L+LBuntf3KjyLXaWTO5qaMLWTaoR59Y+4w9FNvNiVQXcAt3qC5Fvt1EiXkdD5sPXJbStKvi5eRspIKklxDMxomzrXwOshVKWPsG+ZKD+VaCiT9odg5dgZ3JGAi+vumG75SUIUqueBUevognTpTXCgCWpAJfVfSCIn6Czj5Wb8II1wFJa9JppdT4OU2MV8X2ADyJu5dYJ1gJ7G7Y1P3c1BL06nbxfLuByXJXKh2UX6NGsl7vThwjb9BYHtNia19rWIPAs6PcAmgQjKZ2A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18338ee6-e550-4f86-82a8-08df2ae7c60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 18:11:45.8058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cO9cOgek83Ok8Q3e5eYx7fanZYokeu6x+kNn6i60lpcJMO/StTa2BCVh+usUB7Ar1F8WCg1mQmJbl/RTKW65qYq98c+M0XbEZbIEl9A0I90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR11MB387314
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTEwLTE1IGF0IDExOjQxICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
VHVlLCBPY3QgMTMsIDIwMjYgYXQgMDc6MTg6MTVBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gU2F0LCAyMDI2LTEwLTEwIGF0IDE4OjE4ICswODAwLCBZYW4gWmhhbyB3
cm90ZToNCj4gPiA+IE9uIEZyaSwgT2N0IDAyLCAyMDI2IGF0IDA3OjAyOjQwQU0gKzA4MDAsIEVk
Z2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIDIwMjYtMDktMjggYXQgMTc6
MDggKzA4MDAsIFlhbiBaaGFvIHdyb3RlOg0KPiA+ID4gPiA+IFRoZSBURFggbW9kdWxlIHVzZXMg
UEFNVCB0byB0cmFjayBtZXRhZGF0YSBmb3IgZXZlcnkgcGh5c2ljYWwgcGFnZSAod2l0aGluDQo+
ID4gPiA+ID4gVERNUikgYWNyb3NzIHRocmVlIGxldmVsczogMUdCLCAyTUIsIGFuZCA0S0IuIFRo
ZSBWTU0gaXMgcmVzcG9uc2libGUgZm9yDQo+ID4gPiA+ID4gcHJvdmlkaW5nIGJhY2tpbmcgcGFn
ZXMgZm9yIHRoZSBQQU1ULiBXaXRob3V0IER5bmFtaWMgUEFNVCAoRFBBTVQpLCBhbGwNCj4gPiA+
ID4gPiBQQU1UIGJhY2tpbmcgcGFnZXMgYXJlIGFsbG9jYXRlZCBzdGF0aWNhbGx5IGF0IHN5c3Rl
bSBib290IHRpbWUuIFdpdGggRFBBTVQNCj4gPiA+ID4gPiBlbmFibGVkLCBQQU1UIGJhY2tpbmcg
cGFnZXMgdHJhY2tpbmcgcGh5c2ljYWwgcGFnZXMgYXQgdGhlIDRLQiBsZXZlbA0KPiA+ID4gPiA+
IChyZWZlcnJlZCB0byBhcyBEUEFNVCBwYWdlcykgYXJlIGR5bmFtaWNhbGx5IGluc3RhbGxlZCBh
bmQgdW5pbnN0YWxsZWQgYXQNCj4gPiA+ID4gPiBydW50aW1lLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IEN1cnJlbnRseSwgdGhlIFZNTSBpbnZva2VzIHRkeF9wYW10X2dldCgpL3RkeF9wYW10X3B1
dCgpIHRvIGluc3RhbGwgYW5kDQo+ID4gPiA+ID4gdW5pbnN0YWxsIERQQU1UIHBhZ2VzIHVuZGVy
IHRoZSBhc3N1bXB0aW9uIHRoYXQgYWxsIHBoeXNpY2FsIHBhZ2VzIGFyZQ0KPiA+ID4gPiA+IHRy
YWNrZWQgYXQgNEtCIGxldmVsLiAgSG93ZXZlciwgd2hlbiBhIGd1ZXN0IHBhZ2UgaXMgbWFwcGVk
IGFzIGEgaHVnZSBwYWdlDQo+ID4gPiA+ID4gaW4gdGhlIFMtRVBULCB0aGUgVERYIG1vZHVsZSB0
cmFja3MgaXQgZGlyZWN0bHkgYXQgdGhlIGh1Z2UgcGFnZSBsZXZlbCwNCj4gPiA+ID4gPiBtZWFu
aW5nIGluc3RhbGxhdGlvbiBhbmQgdW5pbnN0YWxsYXRpb24gb2YgRFBBTVQgcGFnZXMgZm9yIGh1
Z2UgcGFnZXMgaXMNCj4gPiA+ID4gPiBuZWl0aGVyIG5lZWRlZCBub3IgYXBwbGljYWJsZS4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBBZGQgYSAibGV2ZWwiIHBhcmFtZXRlciB0byB0ZHhfcGFtdF9n
ZXQoKS90ZHhfcGFtdF9wdXQoKSBzbyB0aGUgaGVscGVycw0KPiA+ID4gPiA+IGNhbiBza2lwIERQ
QU1UIHBhZ2UgaW5zdGFsbGF0aW9uIGFuZCB1bmluc3RhbGxhdGlvbiBmb3IgaHVnZSBwYWdlcy4N
Cj4gPiA+ID4gDQo+ID4gPiA+IEkgZ3Vlc3MgdGhpcyBtZWFucyB3ZSBuZWVkIHRvIG1ha2Ugc3Vy
ZSB0byBnZXQvcHV0IGF0IHRoZSByaWdodCBsZXZlbCB0aGF0IHRoZQ0KPiA+ID4gPiBURFggbW9k
dWxlIGlzIHVzaW5nIGl0IGFzLiBGb3IgZXhhbXBsZSBpbiB0aGlzIGltcGxlbWVudGF0aW9uLCBp
ZiBhIGh1Z2UgcGFnZQ0KPiA+ID4gPiBnZXRzIGRlbW90ZWQsIHdlIGNhbid0IGNhbGwgdGhlbSBs
aWtlIHRoaXM6DQo+ID4gPiA+IDEuIHRkeF9wYW10X2dldChodWdlX3BmbiwgUEdfTEVWRUxfMk1C
KQ0KPiA+ID4gPiAyLiBkZW1vdGUoaHVnZV9wZm4pDQo+ID4gPiA+IDMuIHRkeF9wYW10X3B1dCho
dWdlX3BmbiwgUEdfTEVWRUxfMk1CKQ0KPiA+ID4gQWN0dWFsbHksIGNhbGxpbmcgaW4gdGhpcyB3
YXkgaXMgZmluZSwgc2luY2Ugc3RlcHMgMSAmIDMgYXJlIGVmZmVjdGl2ZWx5IG5vLW9wcy4NCj4g
PiA+IEhvd2V2ZXIsIHdlIGNhbid0IGNhbGwgdGhlbSBsaWtlIGJlbG93Lg0KPiA+IA0KPiA+IEJ1
dCBzdGVwIDIgaW5jcmVtZW50ZWQgdGhlIHJlZmNvdW50cy4gVGhlbiBzdGVwIDMgc2tpcHMgdGhl
IGRlY3JlbWVudC4NCj4gPiBTbyBkb24ndCB5b3UgbmVlZD8NCj4gPiAxLiB0ZHhfcGFtdF9nZXQo
aHVnZV9wZm4sIFBHX0xFVkVMXzJNQikNCj4gPiAyLiBkZW1vdGUoaHVnZV9wZm4pDQo+ID4gMy4g
Zm9yIChpbnQgaS4uLikgdGR4X3BhbXRfcHV0KGh1Z2VfcGZuK2ksIFBHX0xFVkVMXzRLQik7DQo+
IE9oLCB3aGF0IEkgbWVhbiBpcyB0aGVyZSdzIG5vIG5lZWQgZm9yIHRkeF9zZXB0X3NwbGl0X2xl
YWZfc3B0ZSgpIHRvIGludm9rZQ0KPiBlaXRoZXIgMSBvciAzLiBJdCBvbmx5IG5lZWRzIHRvIGlu
dm9rZSAyLCB0aG91Z2ggaXQgZG9lc24ndCBicmVhayBhbnl0aGluZyBpZg0KPiB0ZHhfc2VwdF9z
cGxpdF9sZWFmX3NwdGUoKSBpbmNvcnJlY3RseSBpbnZva2VzDQo+IHRkeF9wYW10X3tnZXQvcHV0
fShodWdlX3BmbiwgUEdfTEVWRUxfMk1CKS4NCj4gDQo+IHRkeF9wYW10X3B1dChwZm4sIFBHX0xF
VkVMXzRLQikgZm9yIGVhY2ggNEsgcGFnZSBpcyBkb25lIGluDQo+IHRkeF9zZXB0X3JlbW92ZV9s
ZWFmX3NwdGUoKS4NCj4gDQo+IFNlZSBtb3JlIGluIHRoZSBiZWxvdyBjb250cmFjdC4NCj4gDQo+
ID4gPiBJbiBEUEFNVCBjb21iaW5lZCB2NSwgU2VhbiBtb3ZlZCB0aGUgbGV2ZWwgY2hlY2tpbmcg
ZnJvbSBLVk0gdG8NCj4gPiA+IHRkeF9wYW10X3tnZXQvcHV0fSgpIFsyXS4NCj4gPiA+IEhvd2V2
ZXIsIFNlYW4ncyB2ZXJzaW9uIGludHJvZHVjZWQgX190ZHhfcGFtdF97Z2V0L3B1dH0oKSBmb3Ig
aW52b2NhdGlvbnMgd2hlcmUNCj4gPiA+IDRLQiBzaXplIGlzIGVuZm9yY2VkLg0KPiA+ID4gDQo+
ID4gPiBEdXJpbmcgb3VyIGludGVybmFsIHJldmlldywgeW91IHNhaWQ6DQo+ID4gPiAiQ2FuIHlv
dSBhbHNvIGp1c3RpZnkgd2h5IHRvIGhhdmUgdHdvIGZ1bmN0aW9ucyBpbnN0ZWFkIG9mIHBhZ2Ug
TEVWRUxfNEsgaW4gYQ0KPiA+ID4gZmV3IHBsYWNlcz8iDQo+ID4gPiANCj4gPiA+IFNvLCBjb21w
YXJlZCB0byBwYXNzaW5nIGxldmVsIHRvIHRkeF9wYW10X3tnZXQvcHV0fSgpIHdoaWxlIGludHJv
ZHVjaW5nDQo+ID4gPiBfX3RkeF9wYW10X3tnZXQvcHV0fSgpIGZvciB0aGUgYWx3YXlzLTRLQiBp
bnZvY2F0aW9ucywgSSB1cGRhdGVkIHRoZSBwYXRjaCB0bw0KPiA+ID4gZHJvcCBfX3RkeF9wYW10
X3tnZXQvcHV0fSgpLCBoYXZpbmcgS1ZNIHBhc3MgNEtCIGRpcmVjdGx5IGluIHRoZSBhbHdheXMt
NEtCDQo+ID4gPiBpbnZvY2F0aW9ucy4NCj4gPiA+IA0KPiA+ID4gSSdtIGFjdHVhbGx5IG9rIHdp
dGggYW55IG9mIHRoZXNlIGFwcHJvYWNoZXMuIEl0IHNlZW1zIHRoZXkgYWxsIHJlcXVpcmUgdGhl
DQo+ID4gPiBjYWxsZXIgdG8ga25vdyBhYm91dCB0aGUgcmlnaHQgbGV2ZWwgc2l6ZSBhbmQgd2hl
dGhlciB0byBpbnZva2UgUEFNVCBnZXQvcHV0Lg0KPiA+IA0KPiA+IFllYS4gVGhhdCBpcyBraW5k
IG9mIHRoZSBwcm9ibGVtLiBUaGUgY2FsbGVyIG5lZWRzIHRvIHVuZGVyc3RhbmQgdGhlIGltcGFj
dCBvZg0KPiA+IHRoZSBtYXBwaW5nIGxldmVsLiBUaGUgbGV2ZWwgYXJnIGlzbid0IGFibGUgd3Jh
cCBldmVyeXRoaW5nIHdpdGhpbiB0aGUgaGVscGVycy4NCj4gPiBTbyBob3cgdGhlIGdldC9wdXQg
aGVscGVycyBoYW5kbGUgaXQgaXMgaW50ZXJuYWwgZGV0YWlscyB0aGF0IGNhbGxlciBuZWVkcyB0
bw0KPiA+IGtub3cuIFNvIHRoZXJlIGlzIGFic3RyYWN0aW9uIGxlYWthZ2UgSSB0aGluay4NCj4g
PiANCj4gPiBTbyBwcm9iYWJseSB0aGUgbW9zdCBpbXBvcnRhbnQgdGhpbmcgaXMgdGhhdCBpdCBp
cyBjbGVhciBob3cgdG8gdXNlIGl0LiBUaGVuDQo+ID4gd2hhdGV2ZXIgaXMgdGhlIHNpbXBsZXN0
IGNvZGUuIEl0IG1pZ2h0IGJlIEtpcnlsJ3MgaW1wbGVtZW50YXRpb24uIFdoYXQgZG8geW91DQo+
ID4gdGhpbms/DQo+IEhtbSwgSSBkb24ndCBzZWUgY2hlY2tpbmcgbGV2ZWwgaW4gS1ZNIGlzIGJl
dHRlciBvciBzaW1wbGVyIHRoYW4gcGFzc2luZyB0aGUNCj4gbWFwcGluZyBsZXZlbCB0byB0ZHhf
cGFtdF97Z2V0L3B1dH0oKS4gS1ZNIHN0aWxsIG5lZWRzIHRvIGtub3cNCj4gdGR4X3NlcHRfc3Bs
aXRfbGVhZl9zcHRlKCkgY2FuJ3QgaW52b2tlIHRkeF9wYW10X2dldCgpIGZvciBndWVzdCBwYWdl
cy4NCj4gDQo+IFNvLCB3aGF0IGFib3V0IGV4cGxhaW5pbmcgdGhlIGNvbnRyYWN0IGFzIGEgY29t
bWVudCB0byB0ZHhfcGFtdF97Z2V0L3B1dH0oKT8NCj4gVGhhdCBpczoNCj4gDQo+ICgxKSBLVk0g
bmVlZHMgdG8gaW52b2tlIHRkeF9wYW10X2dldCgpIGJlZm9yZSBpdCBtYXBzIGEgbmV3IHBhZ2Ug
KGd1ZXN0IHBhZ2Ugb3INCj4gICAgIHBhZ2UgdGFibGUgcGFnZSkuDQo+IA0KPiAgICAgU28sIEtW
TSBuZWVkcyB0byBpbnZva2UgdGR4X3BhbXRfZ2V0KCkgaW4gdGR4X3NlcHRfbWFwX2xlYWZfc3B0
ZSgpIGZvcg0KPiAgICAgZ3Vlc3QgcGFnZXMsIGFuZCB0ZHhfc2VwdF9tYXBfbm9ubGVhZl9zcHRl
KCkgZm9yIHBhZ2UgdGFibGUgcGFnZXMsIGFuZA0KPiAgICAgdGR4X3NlcHRfc3BsaXRfbGVhZl9z
cHRlKCkgbmVlZHMgdG8gaW52b2tlIHRkeF9wYW10X2dldCgpIGZvciB0aGUgcGFnZSB0YWJsZQ0K
PiAgICAgcGFnZS4NCj4gICAgIEhvd2V2ZXIsIHRkeF9zZXB0X3NwbGl0X2xlYWZfc3B0ZSgpIGRv
ZXNuJ3QgbmVlZCB0byBpbnZva2UgdGR4X3BhbXRfZ2V0KCkNCj4gICAgIGZvciB0aGUgZ3Vlc3Qg
cGFnZSBzaW5jZSB0aGUgcGFnZSBoYXMgYWxyZWFkeSBiZWVuIG1hcHBlZC4NCj4gDQo+ICgyKSBL
Vk0gbmVlZHMgdG8gaW52b2tlIHRkeF9wYW10X3B1dCgpIGFmdGVyIGl0IHVubWFwcyBhIHBhZ2Ug
KGd1ZXN0IHBhZ2Ugb3IgcGFnZQ0KPiAgICAgdGFibGUgcGFnZS4NCj4gDQo+ICAgICBTbywgS1ZN
IGludm9rZXMgdGR4X3BhbXRfcHV0KCkgaW4gdGR4X3NlcHRfcmVtb3ZlX2xlYWZfc3B0ZSgpIGFu
ZA0KPiAgICAgdGR4X2ZyZWVfY29udHJvbF9wYWdlKCkgaW4gdGR4X3NlcHRfZnJlZV9wcml2YXRl
X3NwdCgpLg0KPiAgICAgSXQgYWxzbyBuZWVkcyB0byBpbnZva2UgdGR4X3BhbXRfcHV0KCkgd2hl
biBpdCBmYWlscyB0byBtYXAgYSBwYWdlLg0KPiANCj4gV2l0aCB0aGUgY29udHJhY3QsIGl0IHNl
ZW1zIHRvIGJlIHNpbXBsZXIgZm9yIEtWTSB0byBwYXNzIHRoZSBsZXZlbCB0bw0KPiB0ZHhfcGFt
dF97Z2V0L3B1dH0oKSA/DQo+IFRoZSBkcGFtdCByZWZjb3VudCBhZGp1c3RtZW50IGFyZSBpbnZp
c2libGUgdG8gS1ZNLg0KPiANCj4gRG8geW91IHRoaW5rIHRoZSBjb250cmFjdCBpcyBjbGVhcj8N
Cg0KTm8sIGl0IGRvZXNuJ3Qgc2VlbSBjbGVhci4gSXQncyBub3QgY2xlYXIgd2hpY2ggY29tYmlu
YXRpb24gb2YgYXJncyB3aWxsIHVwZGF0ZQ0KdGhlIHJlZmNvdW50IG9yIG1hcHBpbmcgbGV2ZWwg
Zm9yIGRpZmZlcmVudCBzY2VuYXJpb3MuIFRoZSBhYm92ZSBzZWVtcyB0byBqdXN0DQpzYXkgd2hh
dCByZWNpcGVzIHdpbGwgd29yaywgd2hpY2ggb25seSBtYWtlcyBzZW5zZSBzaW5jZSB5b3Uga25v
dyBhbGwgdGhlDQppbnRlcm5hbCBkZXRhaWxzLiBJdCBkb2Vzbid0IGRlc2NyaWJlIGEgY2xlYXIg
Y29udGFjdC4NCg0KSSB0aGluayBpdCBpcyBsaWtlIC0gUGFtdCBoYXMgYSBsZXZlbCwgYW5kIHRo
cmVlIG9wZXJhdGlvbnMgbWFuaXB1bGF0ZSBpdC4gVGhlDQpwYW10IGxldmVsIG5lZWRzIHRvIG1h
dGNoIHdoYXQgVERYIHdpbGwgbWFwIHRoZSBwYWdlIGF0Lg0KDQpUaGUgcGFtdCBnZXQvcHV0IGlu
ZnJhIGtlZXBzIHJlZmNvdW50cyBmb3IgNEtCIGxldmVsIHBhZ2UgdXNlLiBUaGV5IG1heSBjaGFu
Z2UNCnRoZSBtYXBwaW5nIGxldmVsLCBidXQgdGhleSBhbHdheXMgdXBkYXRlIHRoZSByZWZjb3Vu
dCB3aGljaCBpcyBhbiBleHBsaWNpdCA0S0INCmxldmVsIHRoaW5nLiBTbyB0byBtZSBpdCBtYWtl
cyBtdWNoIG1vcmUgc2Vuc2UgaWYgdGhleSBzdGF5IDRLQiBsZXZlbA0Kb3BlcmF0aW9ucy4NCg0K
VGhlbiB0aGUgY29udHJhY3QgaXMgc2ltcGx5Og0KDQogICBUaGVyZSBhcmUgb25seSB0d28gcG9z
c2libGUgbWFwcGluZyBsZXZlbHM6IDJNQiBhbmQgNEtCLiBUaGVyZSBpcyBhIHJlZmNvdW50DQog
ICBmb3IgZWFjaCAyTUIgYWxpZ25lZCByYW5nZS4gVGhlIG1hcHBpbmcgbGV2ZWwgd2lsbCBiZSA0
S0Igd2hlbiB0aGVyZSBpcyBhbnkNCiAgIHJlZmNvdW50IGZvciAyTUIgYWxpZ25lZCByYW5nZS4N
CiAgIA0KICAgdGR4X3BhbXRfZ2V0KCkgaW5jcmVtZW50cyB0aGUgcmVmY291bnQNCiAgIHRkeF9w
YW10X3B1dCgpIGRlY3JlbWVudHMgdGhlIHJlZmNvdW50DQogICB0ZGhfbWVtX3BhZ2VfZGVtb3Rl
KCkgaW5jcmVtZW50cyB0aGUgcmVmY291bnQgZm9yIGVhY2ggNEtCIHBhZ2UNCiAgIA0KICAgVGhl
IG1hcHBpbmcgbGV2ZWwgd2lsbCBiZSBkZXRlcm1pbmVkIGJ5IHRoZSByZWZjb3VudCBhZnRlciBl
YWNoIG9wZXJhdGlvbiBpcw0KICAgY29tcGxldGUuDQoNCklmIHlvdSB3YW50IHRvIHBhc3MgdGhl
IGxldmVsLCBzb21laG93IGl0IGhhcyB0byBiZSBjbGVhciBob3cgdGhlIHJlZmNvdW50IGFuZA0K
bWFwcGluZyBsZXZlbCB3aWxsIGJlIGFkanVzdGVkIGZvciBlYWNoIGNvbWJpbmF0aW9uIG9mIG9w
ZXJhdGlvbnMuDQoNCg0KPiANCj4gPiBPciwgaG1tLiBJdCB3b3VsZCBiZSBlYXN5IHRvIGNhdGNo
IG1pc3VzZSBvbiB0aGUgcHV0IHNpZGUgYnkgKGRwYW10X3JlZmNvdW50ICE9DQo+ID4gMCAmJiBs
ZXZlbCA+IFBHX0xFVkVMXzRLKT8gVGhlbiBzb21lIGNvbW1lbnRzIHRvIGhlbHAgdXNlciB1c2Ug
dGhlIGV4aXN0aW5nDQo+ID4gZGVzaWduIGNvcnJlY3RseT8gRWl0aGVyIG9mIHRob3NlIHNlZW0g
b2suIEJ1dCBteSBjb25jZXJuIHdhcyB0aGF0IHRoaXMgcGFydCBvZg0KPiA+IHRoZSBkZXNpZ24g
d2Fzbid0IGNsZWFyLiBTbyBtb3N0IGltcG9ydGFudCBpcyBhY3R1YWxseSB0byBleHBsYWluIHRo
ZSB3aHkgb2YgdGhlDQo+ID4gZGVzaWduIHdpdGggYW4gYXJndW1lbnQgb2YgdGhlIGJlbmVmaXRz
Lg0KPiBJZiB0aGUgYWJvdmUgY29udHJhY3QgbG9va3MgZ29vZCB0byB5b3UsIG1heWJlIEkgY2Fu
IGV4cGxhaW4gdGhlIGNvbnRyYWN0IGFuZA0KPiBkZXNpZ24gb2YgdGhlIEFQSSBpbiBib3RoIHRo
ZSBjb2RlIGNvbW1lbnQgYW5kIHRoZSBwYXRjaCBsb2cuDQoNCg==
