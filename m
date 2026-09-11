Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7721FF2A;
	Fri, 11 Sep 2026 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090250; cv=fail; b=aURKkYL0qIILWBhuwloPFlP9O3NI86pd83LIHSepe22GABudLvfghdvgsG0uiRMSyNShIOt4mGdQUSvpSx91DrIooWUkQDfWFilEfy4l9hOZVtyi9e5HE0MyGNZOHzwhRiRUwawyTzlGHcPIFxLPX+FNAvTu09c+EzfEoW0J19M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090250; c=relaxed/simple;
	bh=HgiiCcfQ+YuhjnCOaQzveaxOwub3lsAamk9vBWQF8ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8RKxxFibeL4siTYDRX3ux49hdPZQYPsJDXtOFCE0b3K0/ucKZ00PkwoGMXm1eDH1x9VsHYUik3U4f29zLOTJSsHdYIWJwcZUx/uxSgCJSVm/7ZDdtR7K/PG3YBEDUHbvLruRS/RAV5b8S92p/86jxCevVWDdAVmHJEX9JZzLTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FH4zDs5Y; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FH4zDs5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789090248; x=1820626248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HgiiCcfQ+YuhjnCOaQzveaxOwub3lsAamk9vBWQF8ss=;
  b=FH4zDs5Ylx7BiOfleYL6sVOYZYxEAuulFV4v50rkdlijYUKykuwLSF1T
   8ySsBSqQ6B3j6Xpmz1c4LkLo/wc3FayFuPO+fZiiDmaQ1N7baFiVnnbJy
   s4nKvM/akSo/kFqdQ4LDqUCveld3F6jN0n0TtTBCO76QEr2RroIhcGm+W
   PHWYzAPVhUgZVmc+oLbe2WFPynTATe7VmCF2gjpAcHYq9LfjRnlUA7ekT
   PESLhYnQUwoYH5Vp6Ty/d9T1Vr7LwnBZZGlhzFLn2izAHYEtIz0jpNgmL
   mVtY1gwN++sgtVRXK4AmquS6O19nbAUrClIG8k2tXH79bzNj2/hsXB+3/
   g==;
X-CSE-ConnectionGUID: /fI0ddmIR+m+QlQnr6DPtQ==
X-CSE-MsgGUID: btZHGjjDTOyj1ajTDGU+Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93379006"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="93379006"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 18:30:47 -0700
X-CSE-ConnectionGUID: qmq/9N/rQd2OPIvE7TfqFQ==
X-CSE-MsgGUID: WA60YYq9RV2QKB+BV9i8Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="272301690"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 18:30:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 18:30:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 18:30:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 18:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7fxwsszFa24UD2LyFrmujJNzlDL+IiCI2IRfWr+0n7l4auDMP+1KrGJ0IbBEyTmaEgqpOWRAoAsZWmf72uqYjvliDFk8GdVFbd4d54eR7tCGUaZIS93+AfQU+q22SrMJ3htLrqtUs/wzQW8YtAvjV18hKxv97k8DU94k0FkwSzAZsrWKATW6AnAnIDBs3dVnZl+uS7IRrxY7drixoQy6BX/8YWVtrY3hxdFpe9EV98846xeDHaAaiKlnTclbtdZn+ttjQEykoWAdIRbXjyvHJGMPh5SgO8MEBccEO8/tMyKHTE44PgNLErx++yWCxw62Qa1ZS6/ugxEMgrqJ7eOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgiiCcfQ+YuhjnCOaQzveaxOwub3lsAamk9vBWQF8ss=;
 b=X2SVGCKcxvRfpdxNPeZoQfqhDiyPZKKpLzb+dTUG7YVdgKft6StkeuYcCItjg32FJDg2RPXHDfP6SMF/dwt81Hizg5GuIrwyPYHvs5nG++i9sOciu6sDPJUYGMAUCVeqzAoMPscAZ/ukzDPWa5t7pOmoatKjVilL/vk+ECcEt/Q/0vdQ+Rcy5MD6lMFObaQ3hkFE9KgsT6eEaeCGs3AnaPG6wzZvaxAb15vnnvhJMUXp0+1eYEVhMAn3HTLvA1TySnqmuj+29N0y64BA4d8WzJpOtV9PuPK9MKjeJ2UJ1udoQ4ASIJJ6abQaEYgcUCYG/ivGF6JLyDNRqmPFp7BbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH0PR11MB5928.namprd11.prod.outlook.com (2603:10b6:510:144::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 01:30:42 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 01:30:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdNdIg5EuCH7XFUE6a3Q+aSzpVqra50omAgACnLQCAAPSngIAAE6YAgAD+CICACMIfgIABRb2AgABhxwCAAA2YgIAAODeAgAE72YCAADmIAIAACc2A
Date: Fri, 11 Sep 2026 01:30:42 +0000
Message-ID: <4c379b90da893c5d1ffea46dc7e40303e7923872.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
	 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
	 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
	 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
	 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
	 <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
	 <d8012e9acbe3c733b082c87fdbe9f229a8f7750c.camel@intel.com>
	 <9abeed40-bcdc-48d9-8cbb-cb87154bb9f6@intel.com>
	 <aqHdwkOFVR4XoS2M@google.com>
	 <c967dc3eb6b128055e415bae45d1c14a52dc4acd.camel@intel.com>
	 <ac43e7f1-2ee3-41a4-85ff-edab7a7caa35@linux.intel.com>
	 <18b2e611bf1d166dde6e27a68719fa5053151af6.camel@intel.com>
	 <4e7edd44-d15e-48c9-89a4-a5baeba4fa12@linux.intel.com>
In-Reply-To: <4e7edd44-d15e-48c9-89a4-a5baeba4fa12@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH0PR11MB5928:EE_
x-ms-office365-filtering-correlation-id: a0922d52-4de9-4e67-0d26-08df0fa44b77
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|4143699003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: mmhVA80LMLivsgSe+DT0qPtZdg/CO1bHSxhkkFbzuOz70KTxvYNOsh1OYxnJwq4QwT+yQd/lzt0JhV/XjP7cvIG8vYYC7L8EiacApokH90w9HUlyvDkaPnO0LGGLLuttMNepSq4fWDyOGqnciyhEd0sU5MpMHOhm6ME2FqSN9G+Aw4DnpUHY4jD5Sv8lTR8uVAJ3zpsK7yJY3L6wkO7qnlIqlqU9pA6AG9Y8iPidf0XcHNgnR6t/dhDjKUTayUn6Qtv5O1RJz1PybZrcM94cInqO1KFbsDz12bdAYYGq6D1nC5LtiTNoD8y70DuUK417c/jLLHesd19p0zbLv9Qmk8JcSmvZrmpE3rkpVmjPgz46OLvsBGQE5QhrgwUQm/rIEIGoBCx/LkBfi97X8cUtGeCcqFZKMRSvj35UkrTn6yE81niUec5tUhrAVtGQ9fbl9V4hNqws8OtUk6RGFZbVC8kd9rtIP4njcdecaidA7Wrccfgts3s+Dq/JuPeWFzgs+DO8lHQabD4StNQlMKh9q3oe7g4x9iGl9kQ4PO3ClcoHU1kggSLeB9U3eoS8VG9H80bAI3LNYp/cqSl+29wqihDaTPYDLWucuZ3K04kXd/YzLnmr10pYgjp3lcOQHax+f/H/gnwv/KzPzGbtZmPjhKePtvX/QmdyHusSJrwANwamEaZr13kDRgfrXn3UW4rOAvmYRWP21ywNbk2+q9M8xv03MfWSA7ovDQXqUS92EEY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHR2Rk5xNTVBSTJNWnNIbjFCNnpLdTNhL2l5cDFTM0pYc2FURFFCK25mOXpv?=
 =?utf-8?B?TG5UOVlqalNXVlQxTzZxem05SDlFazRVdlFnanRLWGhVd3hmSnFSM1JQc3lK?=
 =?utf-8?B?L21xU3Y3R1lrQWVTWUNhZ3ZPMmhVd00zNk8rbUZVVG15dHllYWVMSWZjMzNG?=
 =?utf-8?B?UHR5bGRuKzN6WWd1Ujljd2piTUZYN05DQS9PV3BpOFVKR21Vak8rOVo4OXI4?=
 =?utf-8?B?K3JtVi9VZmt0ZTFpWXJNK20vdWpQZjZUSkpvQ0RqQ0dacnpRQTFaRjh0ckxZ?=
 =?utf-8?B?YlpuS0d3Z2I0RWgybWFaNVhhS1NsVWhudDlYU2VPRGdLcGFUUVJUaFVGblFj?=
 =?utf-8?B?TmlEZE9PTm9qaHEzdmNaZ3lGUU1qM3o5YVEzb09qaUJBWlk0NC9mWVIwemlj?=
 =?utf-8?B?MGhhaDErdnl2TjFSek8zSmM3TUhKVHlOT2ExMWVMZDZuUUtDRVNySXdaWVhT?=
 =?utf-8?B?ejZwYXcwNEVxdmR2d29qc1pFYWRzS0FPM0dSZWJNV3pZWEFmaEh5RWRDQndx?=
 =?utf-8?B?WnRoREU2MVFCYm00bnpqVU8wY2tiYlBwRzVYSVd3YVIwZXFVUTZaREdGTDEy?=
 =?utf-8?B?U2RtTE5zY0JPclNULzQ1SWQzNStmNUJ1REdadlNiRXI3UEFZZmVzbGViMUcv?=
 =?utf-8?B?bGxQTG5UbTIwcU1jMHJsa2VzdnNFaUNaK1hDd1UvY05PNDhSNUVQRWx0bE9o?=
 =?utf-8?B?L0haZ0NJNnRtU0xJVUdLdW9NcTJRU2lBeWhzZTZtdG1ESThQTWRkRGdDNUg5?=
 =?utf-8?B?bVZOQ0VqYmNZUVMvWE53cE5PL3JoYVowU1dOeDlwaEp6aE1lNTdLQlkyQVVq?=
 =?utf-8?B?N29CWHdWU1RXQzVvTnI5ZDdUOWhyYnNvOFdmb3M3dldBcVFvb0loNmRmUjh0?=
 =?utf-8?B?NGZreklSSlZHa3VUMjdpdWRBMUp5L0FoV1JrS05RS2JONEdLMEMvWDhzK3lr?=
 =?utf-8?B?b2Q2dEc4QVZ3cWFxVmZuQktyWWZGMUg4Z1JncVQ2SVJmd1RFYmNhQ2F2Tm1X?=
 =?utf-8?B?eGwycjlScWgxcGV2bGR1R0gwTlhrR1NtTUZWVWRhRUpDcFBIYkZFNHd0TzVa?=
 =?utf-8?B?Y3UzR1U2QmRBamE5RjRlbmEvdCszeU1IcjRZcTF5UU1aWXBDZUJmcjZWcW9S?=
 =?utf-8?B?MVp2RUdWM0xsb2NlNEZLZk9pellzWUpweUdDOWJkLzZtQlBqSGFhNDk2SkFW?=
 =?utf-8?B?WWZHQXlHLzdoTlFPb2tZUnk5OWt5bCtwNTltenVINUdKVEZ3TWhTdFpzNlZY?=
 =?utf-8?B?d1h0d0tsSkRkeFMrL0lTeEt5SDRoTU9INTJwaW1wUDZsb3BFWVVHeFJnTENM?=
 =?utf-8?B?aFhUbnpET0lJdTVJeE9sVys5RVJ2bjVrczBNcllSZ2JBVkVKbTFxQjUydElU?=
 =?utf-8?B?SlcreFJXQmJnSUxjNERUdlBHS0FaVGdNem1VQXBaMXpjUC9FM2pCQTFUUjR5?=
 =?utf-8?B?U0lzQUtZeGt5L25Xa3hTM29IcWlFS3JDMXhITnd5ZHA0WVRKTkx2SFQybzJT?=
 =?utf-8?B?SExFSXVUY2l0SE5Ob0psOGhPSjBDV0U2U0I4K0JvVlRyWlQwYS9uRDlFb3Rw?=
 =?utf-8?B?YmlYQ0syMEE5aVc5cW9OV25GR2hnREVhWkZHRVFKNTg4ckpiQlB3WVNuZGhQ?=
 =?utf-8?B?U3ZZTnBwOFlSTlBGbVlHRzlpeDl1RW91ZWQ1eDNhb2EvU3oxOHU5ZkQxMHdG?=
 =?utf-8?B?ZzlPTkhWMWN6NDUzbnhzcmVuM2tNZm4zWnh1OUlOL0hGczZwSjVSMnhmTVY3?=
 =?utf-8?B?ckhDVnJWUUk0YVVMZHpmQUZud3dBcXRYYkIyMFc0alhUdy83TTB6M29iaTlw?=
 =?utf-8?B?NUpYMW1ldXUxSU9IMEtjT2VOVjZyUkgyMWNtWGFjT0tKamYyaGtkdnBxSnRo?=
 =?utf-8?B?cUoyQVcyeUFEbFNVRmphRy9lOFFjbXRMbUFLdEVWY3hKSC9aU0VmTk9pK1lQ?=
 =?utf-8?B?eTlRL0lNczZKM2xQSFJBQ0pVTWg4Y0pVc3V1bWVwbU9lak1DWnROVGo0MGxm?=
 =?utf-8?B?RG1sbXlFV3lnaWZUWFIyZzNWUE1Nd2t3THhqcVdzZFNIQ1lBbVMzSEtZVWVv?=
 =?utf-8?B?cEg3bDJna0FjaHNuQklxaVpYdnlxbmd3QUgvTEgvbG8zUnpsWFBqb1JiTllI?=
 =?utf-8?B?VnhhcHBqTDdNekpKRnkyWnRvbXNDNXI5dWdiNnFwSEFaUTJMNGZFYnI1Ykhl?=
 =?utf-8?B?Q29NdDdrSWdnVHdzaTB3dWtBblBTZERqSzVLTVVRQWJLQUpOVTNSSGhnMXFZ?=
 =?utf-8?B?dGkvNGNmMjFKMUN4eWI2V0pVQ2hBb0xMTklYcXpwaEhobWg4MVQyK0oyaGVa?=
 =?utf-8?B?aVRPSzlzTGhlR05mZ1NRamVzeGlNNE5Xamp4VU5ZK3lNcWMrWU94Zi9qNWNy?=
 =?utf-8?Q?9/FOwi58U7zH1img=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF5F062D336AEF488E38EB9CB789C8D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o4ZhljzKZYIjhCei8jPC/1S9xTyz0JlITT+Pc/fglu1ghSeYrTrqXxVIrAO4y3UvRRR2szpoL38KCWBXmNEhJa63f9sc3H8+NRtRJAkvl7m07iPUTAB77Ko+wxtQ1xhQp5+FPRDqvIT5modZXqlist9Wxa9e9IGGtm4zuihWPDfSM2SvjQsoCwQ0owTOkyZ+W3wxm7WltoK3xvjeE81iYNX99RYAoXFjA8Cw5UNECB/mMyIcwq3ydcyHUH2jhWjT7w+TfG3jMC1R5qevFEIrO0XT9TgTf74CgumqSAPV2iefYBOADTVPTLkOXr6/uw4qkCNX9jxQEx5ZPPneGsrh1w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0922d52-4de9-4e67-0d26-08df0fa44b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 01:30:42.4937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vh/ot/ToADLNKA52cn1lBgzfSQcSvqLnlPhyBUIq+RcEr18csq91C0yfdKA4b6u6kRUppmIZ1Q8vhUbekFhwRpzaBzJb4kFCpZIKqu9yLtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5928
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTExIGF0IDA4OjU1ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
U2luY2Ugd2Ugc2hhcmUgY29kZSB3aXRoIG5vcm1hbCBWTXMgKGFuZCBtYW5hZ2Ugc2hhcmVkIEVQ
VCBpbiBLVk0pLCBzb21lDQo+ID4gY2hlY2tzIGFyZSBnb2luZyB0byBoYXBwZW4uIElmIHRoZXJl
IGlzIHNvbWUgbmV3IGZlYXR1cmUgZm9vIHdlIGVuYWJsZSBmb3INCj4gPiBURFguIEFuZCBsYXRl
ciBLVk0gYWRkcyBuZXcgbG9naWMgYXJvdW5kIHZjcHUtPmFyY2guY3B1X2NhcHMgZm9yIGl0LCB0
aGVuDQo+ID4gdGhlcmUgaXMgYSBzbWFsbCByaXNrIG9mIGJlaW5nIHBpbm5lZCBkb3duIHdoZW4g
d2Ugd2FudCB0byBhZGQgbmV3DQo+ID4gZ3Vlc3RfY3B1X2NhcF9oYXMoKSBsb2dpYyBmb3Igbm9y
bWFsIFZNcy4gU2luY2Ugd2UgYWxyZWFkeSBhcmUgaGl0dGluZyB0aGVzZQ0KPiA+IGNoZWNrcyBm
b3IgVERYLCB0aGUgZ2VuZXJhbCBjYXNlIGlzIG5vdCB0aGVvcmV0aWNhbC4NCj4gDQo+IC4uLiBZ
ZXMsIHRoaXMgd2FzIG15IGNvbmNlcm4uDQo+IElmIGluIHRoZSBmdXR1cmUgS1ZNIGFkZHMgbmV3
IGd1ZXN0X2NwdV9jYXBfaGFzKCkgZm9yIGEgaG9zdCBzdGF0ZSBjbG9iYmVyaW5nDQo+IGZlYXR1
cmUgYW5kIGl0IGlzIHVzZWQgVERYLCBpdCB3b3VsZCBjYXVzZSBwcm9ibGVtIGlmIHRoZXJlIGlz
IGEgbWlzbWF0Y2gNCj4gYmV0d2VlbiBndWVzdF9jcHVfY2FwX2hhcygpIGFuZCB0aGUgcmVhbCB2
YWx1ZSBleHBvc2VkIHRvIHRoZSBURC4NCg0KV2UgZGlzY3Vzc2VkIG9mZmxpbmUgdGhhdCBhbm90
aGVyIGJlbmVmaXQgb2YgZmlsdGVyaW5nIGJ5IGt2bSBjYXBzIGlzIHRoYXQgVERYDQp3aWxsIHJl
c3BlY3QgS1ZNJ3MgbG9naWMgYXJvdW5kIGRpc2FibGluZyBjZXJ0YWluIGZlYXR1cmVzLCBmb3Ig
ZXhhbXBsZSB0aGUNCmVuYWJsZV9jZXQgbW9kdWxlIHBhcmFtLiBUaGluZ3MgbGlrZSB0aGF0IGNv
dWxkIGVhc2lseSBiZSBhZGRlZCB3aXRob3V0DQpjb25zaWRlcmF0aW9uIG9mIFREWCwgYW5kIHRo
ZSByZWFzb24gZm9yIGRpc2FibGluZyB0aGVtIGNvdWxkIHBvc3NpYmx5IHN0aWxsDQphcHBseSB0
byBURFguIE9yIGFsc28gc3VycHJpc2UgdGhlIHVzZXIgaWYgVERYIGRvZXNuJ3QgcmVzcGVjdCBp
dC4gQmV0dGVyIHRvIGJlDQpzYWZlIGJ5IGRlZmF1bHQuDQo=
