Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3F224234;
	Mon,  6 Jul 2026 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369602; cv=fail; b=INyN1irmQCoT6uuBZCpvzje5yWoGPeHAKiV1RgZ8mHNEO4a4R4fuQ3u8Rvzd7xDihQBoZjhTOSuNiCH2jcl3KszA+j051SBsLeP3BIOjUR3mpCQ8XLATjhhSPqP40WcAWyOjd3qg9P0ZgjoUarb+jVPVXrbEF8rTIa87CJF7SCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369602; c=relaxed/simple;
	bh=9iCGc14JhsIDqyVoy0Tx68e8qfgA96t0+YMBdf+mM/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cyg9PNOD2vckRNuJBM8ZsTZtUEz8U/dE69DfpOzCrDX99sV0EFFl5OZhVCqwSlZUrDtBrmsHDNxMPrk0RO6zybgBd6D9ZmruIbCvRDhg7D9rVdbrIm1PC8o/ivoJwRYm+zUjBmX6MyJ7VeVW+kvRGLfvIy87yGXgcubEnSBwIQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4Rnx0b/; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4Rnx0b/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783369601; x=1814905601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9iCGc14JhsIDqyVoy0Tx68e8qfgA96t0+YMBdf+mM/o=;
  b=l4Rnx0b/DhcYKh4qhKYIrU9ryDe+CyXRFXs6ZDkBYdY2nNjTnAgi2Epy
   5uo+JHn1Q0gGscwr93NldnYuxxI14pOIzpfF7ckhuNlLBF7nhvCdX1L1K
   ITkADGAbzWHXgqSdNmQMiv4nocMRUTIjzBoUWTI3bbyL30W5Qh/dAJ67S
   8M7J7XIjPQf8JkxakAUUQu5adV1Ol8onsPEK5VWZInMk/oK3RAtD9Siop
   karoHc9CSfSKf1MTPId/ztyCizJGKFVqvzBcgThx8EQ5Zd7T5UAgEGrxl
   N04dGEgp7G0MsVldkWE0pk0p5p/UosYhgNFrXMvA9LAJTITKTZWd51j9N
   A==;
X-CSE-ConnectionGUID: jaTb5fRQSLysRocv6TpzbQ==
X-CSE-MsgGUID: mTjldknDR3m5lhymkVvgmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="95526628"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="95526628"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:26:40 -0700
X-CSE-ConnectionGUID: woqB7ndOR5a9YfV/UuvXaQ==
X-CSE-MsgGUID: CL+ZktcdRK2yzt57Hi4pGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="257384029"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:26:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:26:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 13:26:40 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:26:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXs3uaQ9dwzGRM3SrNi6Q4ilTmqiKMciOzIGmtk6JXsxTjZqLe6tGTxaOoUmMWcPZCLJOQ7EhZ5onOBvFDnaAeUzQo/L0CpYzwiWmaWo7RmQSVas1jReSX8h4W3iOm/CVAAd73zsEcKwMGpBBAbf9CTqkMg/uu4a9rUx7Kcr5fOtxVfjlFAF5X07Db+WxrNbzNiCeJzplNR/KWUVsb3vXA5EhLTGsVdDIXn9lmSqnKEnveqrCsivF110P3El+mI8Ro5SC43Nne5VJsw10I9PVU0NBWMG/WJDdbvaczk1fPIz1pkZiUDTRAShS2qlX1gYWMIvxthzqQBT0C2nMws27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iCGc14JhsIDqyVoy0Tx68e8qfgA96t0+YMBdf+mM/o=;
 b=O9+U/lsawGWUPlRoYdvPQ+fBA7Z8/f48g854wlwTvzUlyo9KnvJvX6DqS3EAtqAy4sojPu93+DnQoqsEKsjkPmqgKeILXEUhM520jNQMgwxzYedCsIS05dxu+qnoyJoAIjMO5U9Ic9pLbOwtAaO1VJ4z5VTU8nbYeHx8kxwzqmD+58/5pZxJXXtvgD4VYdsuocSBXKvVkUxcR9/ke1IaNNnWwOCdTN4rfFE9CD0ppoDh5F8f1Vlx8+TaNK150Dp48r7cmc3ytyHcnQQs+XNs9n87RY1DHqa8Z9vFKxqEebjxyEOkJrLIYvI/4Qa34PIvK7exQYoyVxbm+E5pswspnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 20:26:36 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 20:26:36 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Thread-Topic: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Thread-Index: AQHc7LhU1bCbzezxb02fxsgzvwPwJLZaDRwAgAck7oA=
Date: Mon, 6 Jul 2026 20:26:36 +0000
Message-ID: <205fdd6fbc7dcc659d764616d0edb5da155860d4.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-5-rick.p.edgecombe@intel.com>
	 <ca22e5c5-9742-44fa-9c47-e4134e832d49@linux.intel.com>
In-Reply-To: <ca22e5c5-9742-44fa-9c47-e4134e832d49@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB7947:EE_
x-ms-office365-filtering-correlation-id: 3027c6a0-b043-4d09-a62b-08dedb9ce0a1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|38070700021|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: ghQbV2MJ6PF55Ru0saP/NljzPNylnCRI5SHfTmo2Z0BN6lJ4Hq2tJLrlHDHHri/PQK6v+U15FWI9bVLld2LEQyzQyHs8NdHmOf5Dcz90yr+ci2di82wuttsicT1CSN2Wt4a1L/CMQI+ONgWqOUigsogikvknOGFeChf5jbYQyPB4fefWb13w+Yzj9H3zyPnAJzZgTD3aGonYcpMuuDa4uT3I272cjVy4/0hi8ovRJrqSeLioheAX9xliXSEjt5wIdZXj9l33k72WXhV0gQ2m/Gp3wyQUdGpetXgkrb2zkqbpcIZ2ov1kXkOpDzholSyNBAeUnhsH+VVOaIfyEFUE8f9fHss/PIZes8Sra2CkOixkT5zc+1Y6Fmry4zM4JPYfhLPg1pM2v3I9Yubi9063ztzvu8JgrbDdba+qdFwIFLTao3f93stfgk3/pNyChX/JPqBBA4MUYs0m7PiCs3N08YDvLvbbnIrzK3rXHdlU+A6A0whappQg76UMASUzZsQAVtZYx8MlokqrvBbWvDkF+gr3G9Kbf6WXDiBLxGqDI7F6B7ZKsi43ZBOmdFEkxNKNegSd9hBcpuQ5+2ykuQPiu9qS6psl9iq1ILZOCsng56zhsYu69GXjnYu2g9s1W9Pf+ya6ctVTHMxPEcbWdAPiXhII+EPzxjb4QzWubjzLCcIpN7mY1dIAL7lAX5DZep+MBlE/XbbGaoKaJUVEsz8eI7tOxwB2wrSLeo1sdxInhk0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmZVLzN5RmppcXA2UExadXdKNllVYVNpdWgwamVWTFFwallvQ0xmWXArZVlV?=
 =?utf-8?B?N0RjMDFFZTJMV2hqdkpMMkFKeVZUK0dBelVIczlmK24walI1M0Ixem9RdjM0?=
 =?utf-8?B?K3V6eUM4TlZ6VGVxM1hJVUE3aHE4QTJ5ek9FMGpqa1cwb2MrTWxsdFM5ejJQ?=
 =?utf-8?B?ZUpjakQxMmlOS2ZWckZrSUQyUEVtN1g0ZDg0YnY3N3BSZHFaL2o3cUpQT1dD?=
 =?utf-8?B?Yk9JQlVNdDFtWWo5bnQ2Y2M3Z2x5MElBVTRaOFUzWC9kMUtIM053bDVkVndp?=
 =?utf-8?B?c1MrTlZxb0g1aldRcm1zUURGamZlWVdPeVA3ZHlKN01ON3NFQ2JBVmJ0UWxv?=
 =?utf-8?B?amlBOGlwZWV4MTFWTTl5YmJwWlFxTXpwY0VSZzduWElXTzJxOWVxa291eWVP?=
 =?utf-8?B?QnR0V1N6RjIvN0t2aytSN2czaTk2VVpST2k4bTBwRDVWNDMrQmVMclhHWVYv?=
 =?utf-8?B?Q2VPaGJnT0pIVkxIWTN3akVaMmt2MnZXY1M3TFJTUWp3czc3YmFNWlZ6QzZJ?=
 =?utf-8?B?VzhRYVhxNzgySmovaGRVZFJsM3Bob2gva1QyMDNObTRNK0t2ZEN1cTN2MTFM?=
 =?utf-8?B?V25pYVIyQlBOQytlTHZUa0pNbnhpQ2VhaGxiNjdqZFJEcG94QVNrWjk2R1NU?=
 =?utf-8?B?MkR5WHREQVRGRmtYcGdYUXpaOEV6RmNuRnZnTUxzMW8yVzBMeGZqdFBqVXZk?=
 =?utf-8?B?UFJFdlVrcFgrTUR4KzF3Wjlvb3dGRnNkdnVsZHZuQzIwV1d4TDhyRmpRcHd0?=
 =?utf-8?B?SGFwbHV4MGpFK0V3L1AwODFLT01vVFdBUDNzbkZrUmZ0ZkdWYVZGcVNFdU9D?=
 =?utf-8?B?b2VtNnZ5T2pCWDYvODlURE92RVFKOTVRYndLRWpHRkU0NnJpSmZ1ZHVISTBr?=
 =?utf-8?B?MUpKNWpsbVowajNKK2JjbWYxdjdIUXdQdzRaNDE5QVBqWEtPZEZPUzI0b1BX?=
 =?utf-8?B?dW5mQzE4aVlUMFkxN0VLc2hYdHhta0VUS0d6N3BkSDVCU1hHSVphdjE1cTV6?=
 =?utf-8?B?WVRIUEVkaFBGQnVtb0l1VzRaRGU1L3ViK3pxbHZOcGhSOWE3Qm9qQ0dXalNS?=
 =?utf-8?B?YURqOFVuaG8yWXFMYWdPcm1WTEpVY0RzbVNReFdRbStVZG9NaGRRMWpvZjNw?=
 =?utf-8?B?Y2RITDhZVUswc3dUTFIwR1J2VWhlY056ZVZjT3M5Snd2YUtZTlNUSWwySXNN?=
 =?utf-8?B?YnZXc25qbEZOS2NFd2Y4WlYyOHRFalA1SmkwdlBYWGlWMUMydHkvRUEybHB6?=
 =?utf-8?B?V2FoVFQ4KzRwNTdwRnZtc2tMbWMyU1haSitKZFhjakExMDNRVUpDMmdTT0ZX?=
 =?utf-8?B?TGlaTG5icUN3YiszVG5scFBCL1h2UEVIRm9Deml3MnY5ZGsrY2NTTXBxVVBX?=
 =?utf-8?B?TytTKzhtMnBobXFVUXJOTWJ3cUU3dG9sQ25WVEhrMmxzZC9WUDgwVFdsOUNS?=
 =?utf-8?B?cytVRlRGalU1YVFtUkxIZWRUZDdVT21QYWtvNk1Rd1lDVFhsdXJ6eEJDM0JV?=
 =?utf-8?B?ZmwrbUZSc3JZYTA4alY0QTgwNXJHWDZCcC9PLzhEUk9wQk9CSDZxeTZKRGxI?=
 =?utf-8?B?KzRaVm9veTNOQWxxNVU0bXg4aUJxYUQvaFY5S1dkczdUbWN6N25ZZjJxWlBT?=
 =?utf-8?B?bzh1UGZSek1HSEZvZkJjbHVTVTZyVzVCWGJBM1dmSi95UGFzNGNKRzZoTEw5?=
 =?utf-8?B?VUVYczJIYS9PM2thalUyUXFGdkJqWFdScnBaVnZmOE1kQUxLZTZORTFKdFZL?=
 =?utf-8?B?TDQza1ppaHA4U1RLMFRpd0Y2MjdzSCt4Q3E3eHZYWGNyQ3B6N0htSDhmSVhC?=
 =?utf-8?B?cVpzZG85cnJPSXNFQis3eDRGUGZKRFpZQWZFZlhlcStqZUZ6QnlUcXk2amI5?=
 =?utf-8?B?eG9nRkJqQWJHUklna2NTQ1dxY1pucm12Zk5rNms4MHV0MlJVK05iUm9wWm9M?=
 =?utf-8?B?cGk2MUMvN0RTTUlyeXRJUHNMeW9wTGR3Y3BreHlYRlAvN2V4TTlEY3pDcmdC?=
 =?utf-8?B?a1kwZnIrcEFaWFdtUXF5Zk1kY01SNVJ1RDdvZnBxZFJEVEZnS3dzVldOMTlG?=
 =?utf-8?B?YWtCdGszTUxJQnhXa05DSDNzN2x4ZEJqdDV0NXhONXhsZ211ekJQbEdST1FS?=
 =?utf-8?B?UytBMVhJSTMyeWE3cWxJWUphRnZzUStwK1NYN01FQ0QvaTBtMEN1ZThlRXl5?=
 =?utf-8?B?YWVkMHI5WjE3cXA3YjJ3amJLRVhXSWJFajl2dXRRTENyQzR2NkVTeURvZk93?=
 =?utf-8?B?dXFOZTkwSHp0dUEvY2lualRBbENnM3JWQnlGdjlKV1JwdlR3aFZiWUo3U3RN?=
 =?utf-8?B?NGRTcFBNSWpjMTVDajVVZDZ5V3pGL0pkS29VNVg4U0NaZXNnaVV3bDAzNFJp?=
 =?utf-8?Q?CUdXMbQmIyLUwqJw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <569DC5376802A64C9DEF38088C494B46@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Fv6aYjmgtzH1h8wfQw9xVgGFNil7kShA0dgefNvGv8r6bpF0t6oloOH84D21zbLJsGCRCnahcgTpeumM2G4cCyzo8/BAPqZ4dmBzoXkDajMB2zrN5ZeeOdHK3HXfR9zdt0gfMpSUGCtEbgUtSXWL2KXJY5Exog6ouZn8XMsw0xWPOZbKT5lGjxns7igAPl4libS0fYcohpAqzPf0sjXS/EyAM9wbjtWc6wSvMA39qC0DujZwnqHFmDt82DuUcGKVnEoB95hXOB0pA3+IlY2ArzwSAj7pfN75LykBEy8Z0uCfCqykmTNt6t+kho5+NS7Qe8C8dBQipwOzaQe5ce1LTQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3027c6a0-b043-4d09-a62b-08dedb9ce0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 20:26:36.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nr9sNnQf+bQXtLN1YZuyAbFog8/vIdICPaAURDHJeMKk54sNGgvkBwJQxs1t9cDFhInTSq408qDXvNYdiloC4nHHZXYX2Oy6M1TJjNdtg0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTAyIGF0IDE1OjIwICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IE9u
IDUvMjYvMjAyNiAxMDozNSBBTSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gRnJvbTogIktp
cmlsbCBBLiBTaHV0ZW1vdiIgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+ID4g
DQo+ID4gVGhlIFBBTVQgbWVtb3J5IGhvbGRzIG1ldGFkYXRhIGZvciBhbGwgcG9zc2libGUgVERY
IHByb3RlY3RlZCBtZW1vcnkuIEVhY2gNCj4gPiBwaHlzaWNhbCBhZGRyZXNzIHJhbmdlIGlzIGNv
dmVyZWQgYnkgUEFNVCBlbnRyaWVzIGF0IHRocmVlIGxldmVscyAoMUdCLA0KPiA+IDJNQiwgNEtC
KS4gV2l0aCBEeW5hbWljIFBBTVQsIHRoZSA0S0IgcmFuZ2Ugb2YgUEFNVCBpcyBhbGxvY2F0ZWQg
b24NCj4gPiBkZW1hbmQuIFRoZSBrZXJuZWwgc3VwcGxpZXMgdGhlIFREWCBtb2R1bGUgd2l0aCBw
YWdlIHBhaXJzIHRvIHN0b3JlIHRoZQ0KPiA+IDRLQiBlbnRyaWVzLCB3aGljaCBjb3ZlciAyTUIg
b2YgaG9zdCBwaHlzaWNhbCBtZW1vcnkuIFRoZSBrZXJuZWwgbXVzdA0KPiA+IHByb3ZpZGUgdGhp
cyBwYWdlIHBhaXIgYmVmb3JlIHVzaW5nIHBhZ2VzIGZyb20gdGhlIHJhbmdlIGZvciBURFguIElm
IHRoaXMNCj4gPiBpcyBub3QgZG9uZSwgU0VBTUNBTExzIHRoYXQgZ2l2ZSB0aGUgcGFnZXMgdG8g
YmUgcHJvdGVjdGVkIGJ5IHRoZSBURFggbW9kdWxlDQo+ID4gd2lsbCBmYWlsLg0KPiA+IA0KPiA+
IEFsbG9jYXRlIHJlZmVyZW5jZSBjb3VudGVycyBmb3IgZXZlcnkgMk1CIHJhbmdlIHRvIHRyYWNr
IFREWCBtZW1vcnkgdXNhZ2UuDQo+ID4gVGhpcyBjYW4gYmUgdXNlZCB0byBoYW5kbGUgY29uY3Vy
cmVudCBnZXQvcHV0IGNhbGxlcnMsIGluIG9yZGVyIHRvDQo+ID4gYWNjdXJhdGVseSBkZXRlcm1p
bmUgd2hlbiB0aGUgZHluYW1pYyA0S0IgbGV2ZWwgb2YgRHluYW1pYyBQQU1UIG5lZWRzIHRvDQo+
ID4gYmUgYWxsb2NhdGVkIGFuZCB3aGVuIGl0IGNhbiBiZSBmcmVlZC4NCj4gPiANCj4gPiBUaGlz
IGFsbG9jYXRpb24gd2lsbCBjdXJyZW50bHkgY29uc3VtZSAyIE1CIGZvciBldmVyeSAxIFRCIG9m
IGFkZHJlc3MNCj4gPiBzcGFjZSBmcm9tIDAgdG8gbWF4X3Bmbi4gVGhlIGFsbG9jYXRpb24gc2l6
ZSB3aWxsIGRlcGVuZCBvbiBob3cgdGhlIFJBTSBpcw0KPiA+IHBoeXNpY2FsbHkgbGFpZCBvdXQu
IEluIGEgd29yc3QgY2FzZSBzY2VuYXJpbyB3aGVyZSB0aGUgZW50aXJlIDUyLWJpdA0KPiA+IGFk
ZHJlc3Mgc3BhY2UgaXMgY292ZXJlZCB0aGlzIHdvdWxkIGJlIDhHQi4gVGhlbiB0aGUgRFBBTVQg
cmVmY291bnQNCj4gPiBhbGxvY2F0aW9ucyBjb3VsZCBoeXBvdGhldGljYWxseSBjYXVzZSB0aGUg
c2F2aW5ncyBmcm9tIER5bmFtaWMgUEFNVCB0byBnbw0KPiA+IG5lZ2F0aXZlIG9uIGV4b3RpYyBw
bGF0Zm9ybXMgd2l0aCBzcGFyc2UsIHNtYWxsIGFtb3VudHMgb2YgbWVtb3J5Lg0KPiANCj4gTml0
Og0KPiBEbyB5b3UgdGhpbmsgaXQgbWFrZSBzZW5zZSB0byBwcmludCB0aGUgbWVtb3J5IHNpemUg
YWxsb2NhdGVkIGZvcg0KPiBEUEFNVCByZWZjb3VudHMgaW4gdGhlIGtlcm5lbCBsb2c/DQoNCkkg
dGhpbmssIG5vPyBCZWNhdXNlIGl0IHNob3VsZCBub3JtYWxseSBiZSAic21hbGwiIG9uIHRoZSBz
Y2FsZSBvZiB0aGUgc3lzdGVtLg0KV2UgaGF2ZSB0byBkcmF3IHRoZSBsaW5lIHNvbWV3aGVyZS4N
Cg0KPiANCj4gPiANCj4gPiBGdXR1cmUgY2hhbmdlcyBjb3VsZCByZWR1Y2UgdGhpcyByZWZjb3Vu
dCBvdmVyaGVhZCB0byBiZSBvbmx5IGFsbG9jYXRpbmcNCj4gPiByZWZjb3VudHMgZm9yIHBoeXNp
Y2FsIHJhbmdlcyB0aGF0IGNvbnRhaW4gbWVtb3J5IHRoYXQgVERYIGNhbiB1c2UuDQo+ID4gSG93
ZXZlciwgdGhpcyBpcyBsZWZ0IGZvciBmdXR1cmUgd29yay4NCj4gPiANCj4gPiBBc3Npc3RlZC1i
eTogU2FzaGlrbzpjbGF1ZGUtb3B1cy00LTYgR2l0SHViIENvcGlsb3Q6Y2xhdWRlLW9wdXMtNC02
IFNhc2hpa286Y2xhdWRlLW9wdXMtNC02DQo+ID4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNo
dXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiA+IENvLWRldmVsb3Bl
ZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBCaW5iaW4gV3UgPGJpbmJpbi53dUBsaW51eC5pbnRlbC5jb20+
DQoNClRoYW5rcywgYW5kIGZvciB0aGUgb3RoZXJzLg0K
