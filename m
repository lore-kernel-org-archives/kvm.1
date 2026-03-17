Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A837CD42;
	Tue, 17 Mar 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769918; cv=fail; b=MMnXwhK8LOGtgrf3jRdhctLD2+3svx0oEkvGpIf/Wk9L1wTgdFJkho27wb3EzXMF4o0A04J+iLXwR55y7DsnX9rh5Lpe78Z6qSmW3yXbpMrgTx80tjmmjayUKnroJso6ivioh/HLJCXa1WuC46Gv6rM+G8q90Isy0CJYRIy+x8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769918; c=relaxed/simple;
	bh=yPi/9/oJ/qCiL3SZz8q0SGzKA/SUa7hqeBTJ1CZvZjw=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fdo0gY8zR/wE988yjjL2T1KDIgO7+z+u+qr099ssWximO0MB8jY7XflEUKPc5MbI7DUCA3jrE/su751JazGo3eUTkew1fBRjAy3ljcbC9USHgmrlHRsg8QJAfM96uzPz7NAtd8supIvE1lh8ya/o/eZWFXrSO4EJM53lkCc8SZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmfCoY29; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmfCoY29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773769917; x=1805305917;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yPi/9/oJ/qCiL3SZz8q0SGzKA/SUa7hqeBTJ1CZvZjw=;
  b=mmfCoY29tLTJXw83xpliS3pH4UMfbJ1UChXufxMv/ICitW4sVUNBcm1U
   ISJbk2k0M5G5/cCb9mrwzDiXFskKuj9sLvjLf+VXmdSC9S1Zqd6pU5Jpe
   fpd1E9DAxUm3PtMoDxWBIJxeTl1LFvhkEWAOeUVcS7K8yDWgpXdbtf3J3
   n7wwN5FzYiRUTpI2cbZF1UoQplxIuBIjzsvHVQtDHP1LyUa7gPOvxDdYG
   iuI7hzwKiK+4YuA3+EJ+rwW+P4eoVYb9INsUUYFajVu1UnHv2ZkPYz2/Y
   iXnoc1nmmnDZt0KBjIB61JfJ5s281vUN4vjq2ABq/rX5IZUTFnvjq8QKl
   g==;
X-CSE-ConnectionGUID: GCO07y9PT5WCLSfxks17ZQ==
X-CSE-MsgGUID: /VNAGOd2RzqUQiW/5C1XNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85508629"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85508629"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:51:56 -0700
X-CSE-ConnectionGUID: wD3j58I/S8y+5+1wSgjHTQ==
X-CSE-MsgGUID: 0po1pumHRZyudKtsJ5tYAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="221411637"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:51:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:51:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 10:51:55 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:51:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGjgIJfy/EMOPJGHYxbEqWl26kEBAmsyOF66HUrTeTGcm5uiJzRY8glCdqgpc7xgLenJ4iC+R2lWJzabbwbeSDMrI6nNDmBqpNh0vi43JPkwFzCRteLCYhNO26xS+xldFGPwp3zZPMFijYGDBN91ZmBP/CGPDpXkCKUaYaEaSBKrHuD+XXGr8EEUUwMbYY2xBp7/IhKUGhzXLXY9bu2Hr074zdeKuv/LIH/Q975ntntHgvT5aZInP6Jsorv02jgxdPs3DToZXHTxJ7go1wv41bbGvHPJoJIXl8Hupg8aNK483Sth81te6H3BGmr46y+nV1iWhUvCoflzSvQ5EqYInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obS1ZbuRB6IrXHR3FuFf0uirwJAWa7i1Z7ui6wqgdfc=;
 b=M284FG/u0Y3C7OGcFcZcg7yp7Z8u7YpC1nbtnhtFz7VvqFSbOvgOeXq34DKCxT2y7isAwRUQxXHGpwbZlDVngBn1KJeQluzMj/ga+6UK47aDLh3hbZ6dfEO6boLnnmtRlTu8biWb4+wR0Ue6GFDGBiXTAxh3eEc9h4fppUSbb99KDCecCT2Exzxhyy550UN94TSKB0WzmDPYgIrfQlhEeXtwT+xKQm1LkerT9NQiU6ajxLi0eiOz9TVRJhqF6EbllEc+N9+EaZjRz/8THQkv2B+xUbljQ3onb9tVPnKkaQKu7fdj9lkiikuyse6aRnhPAqepu+NtsNls65PU/pxXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 LV4PR11MB9467.namprd11.prod.outlook.com (2603:10b6:408:2d8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 17:51:48 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 17:51:47 +0000
Message-ID: <952533d4-4ed1-426c-a4f6-287a15d2c714@intel.com>
Date: Tue, 17 Mar 2026 10:51:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, "Nikunj A. Dadhania"
	<nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov
	<bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <jon.grimm@amd.com>
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
 <c13736a1-3151-476b-a91c-035383d2a29e@intel.com>
 <541cddbb-22b3-4865-a374-49ba3ba48a5e@intel.com>
 <a91b5d2c-c152-4a11-b4e5-93e64d0e8958@intel.com>
Content-Language: en-US
In-Reply-To: <a91b5d2c-c152-4a11-b4e5-93e64d0e8958@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|LV4PR11MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fb38c9-8772-479e-8fae-08de844ddc28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KwByCqM/2S7+rXrCGU5+bAiH8tCVVd+XtWC/kcqhwAqLP50gqjwuKShSFcmLJti4gGz7ODlabpPlzVZMabHgZnf8d3H6D0UN93tmu8NVud5r2BboN6/AXWZyTPZG5UEcj2rZ/OvyGNOWgVF6lcr3JkBJ6qjd0N4C7WlGmlDRZrDUOAAu2r+7p4KwvTripcfPFXLA77C1UYSLVETDmZ+Io6+ajEYYLUrtRZ1E/gBW296Ip1ZzI55dVT2p+BC/dEC6X/t8hfssm6c9Hvn96K+tPGUrkxlZnRmfJCMM8SjJ/+ulIpyjErq5XU0+8BdJzRELf3cs1E6a4fm8jgKC0dg8CCdNlDj2fDTSZpiRUoF2BmU0SQeEVbG/54ELUS0aCHcLYeBZz3ymSyKPZ6AMqf70BJIV1sI7ARoEJ4g2qgVaD4+RvGFs/PxcYHo6M+lTdmpScgNVude9UvL7u0I4DfASdITOYFQP6ou/3TNxIlu/NG5QGn8R21+EZHSyvUPHYMhATq9ofhRhA/637+6S7qKyKpcagLKvwIYH1ZVD2GEv29f3oOFjy6CgdFjMNslnLHMw+DPwfRzaYKopH8ao4Go7HjRv/zijJZRarkf49Oz1QDht6aNoZshNGs7g5gJmlTw36HyqmWq6HYzvFN/oI4Ttz6vb0cntKWZzgfUNOJ+RIXz3/y9z3ctHljBnsDPyzsIhfDwfx9Jbpn6F/lxw+RkrbI/f9wLUcc4AfBL4g/YftZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTVMdE5SZkV5L2tNMVBLbG90NjJ0SGdHTHlweXZodWplT29uNmo5ZlBBbEI5?=
 =?utf-8?B?Wnd3U1E1TmNWMDJoa0t5Z0lYRGMva1RZck5IeGxLNm9SeVExaVFXRGVxTGdJ?=
 =?utf-8?B?OWZHWWRIUFNlM1U2NVFVS04wd2VESHJESi9GQWZUQnVyc3hYODZmdEhLVGxU?=
 =?utf-8?B?R3NaZEJ5T25Md1JkbUdIcFdYVW01L0xhT3oyYmRxOU9zK0llSFdGVGtpbERM?=
 =?utf-8?B?aXlTMXlkV2ZKRDN6SWxZRmEyOGVRb2RHMEkxZ2NhNERZWGdFUkMrUEhLZS8r?=
 =?utf-8?B?eXBOck1odlk0aXZ2TmdZeUZkVUZzcTlPZU4rNmcyK0JWTy9kc2NUeTZzdVJ5?=
 =?utf-8?B?akZ1V0JqWDVheFo1K3JPZUNxQ3Q0UWxaVEpxb1VOL1JlUFNIRldzWWlqbDBm?=
 =?utf-8?B?VGhTcFpZbEtUZmY5YXd3L2F6VXVGcVdUdEs2NEdVV1NNVmhxUWVlcmdMYmJZ?=
 =?utf-8?B?R2dZY055amxBdGRqOHZSZlpOWE5qb20wOWR6ZmRGbzRnbmpSS1RaWTFzRElH?=
 =?utf-8?B?L0JXS1JXTGdhYUZLa1dqWFVzbENGcWVzbUFxdUg1QUNOSVpqd0pWUU9ZMHRw?=
 =?utf-8?B?MElyZTN4OWtLRUl6cUwxUVprSlltSk9mSEMzdzRtUkFkcUg4c2lrZzZuMU1B?=
 =?utf-8?B?blJHSENaN3BHNWRxOVc5VGVudlVnWXl3UUR5T1hRdTBhSFFNYzVER1U2QXNI?=
 =?utf-8?B?TDFhRTgwUnBySjBHOGxrdU9rOHVXbVlQcitRU0lEOWNWWFM5c3FJMFVNTnA5?=
 =?utf-8?B?NnJ6YnN1NW5zU29nMEFCVTA3UEVUWFhLT3VvSytVTmRxemtFNWF1MDVmU1Nm?=
 =?utf-8?B?Y0tMVmtoVkk1aXJEYXJsZVhsM1lvcTBxRGNleDJyVis5NzQ1R3pMTW9UYzEr?=
 =?utf-8?B?aEhtWXcvbDRGYVkvL1JQNTJZZVJncERBREh5VTJPNkJuV1RnODYva2tWaVVZ?=
 =?utf-8?B?VkZpTTluMlNLSE5ENm01VTJTSXlMc3hUUlVwTlJJSURlcjJSblZlU3VQcWp6?=
 =?utf-8?B?L3RCNlh3bEplWFZPYWFyOFhjTExCR09KamJuaE1NMnFncGdSRElSNmlYN3l3?=
 =?utf-8?B?clpmL0xwVHJpOXg5VzltdS80V291dUo0V1BOZ3MxMGFybVp0WU5GSkVEWUp6?=
 =?utf-8?B?cVRQTkJrSUhYMmRJOGI3RTlTdGFoQ2hjSVMwTXRzaEx6cVg2VzR0TnZxMjZX?=
 =?utf-8?B?L1l6OFEyV2gwMkg1Rit3MVd6dEpTNEs4TVJrS0VWbnZLdytRdmxQRlBDUm14?=
 =?utf-8?B?ejB3YVNIOVg1bGhseDU1c21yYi9EcHcrdFNuVmIrMTE2dGpwcVVSUyt5cGUx?=
 =?utf-8?B?QXpRUVBabDdLcHJiNm5ZZ2Z6OUs1VW9vY1d2OWF6N0FGczVJekFJdjNaRDFw?=
 =?utf-8?B?cFJZcytmNnYxTGhmenova2pjdkE5U0dyTTMzOXJkQ3dtQmw1SFlmdTAwT3B4?=
 =?utf-8?B?YTJ5ai9RUnRjeStmeWRlNERsSDNheUVBNlhYNlprSVV1azdFa25uU2ZxN2VV?=
 =?utf-8?B?V3ZtcVM5SkNoK3JyK2RaeWtMU0x2RGc2Y2ZuWjRZdGR2dWlMc1dEMThWdnpz?=
 =?utf-8?B?NGxmbG01TWh3d0wwTEFZakFiU016MWc5UlZYTndLVzFnTTl3YmhIeGh1Yis2?=
 =?utf-8?B?NmVTQkxqSG5TcTFPalBQbFNncWtmZFFBbVFJN3FzM0EwVWZ6K3hLWitkZnBV?=
 =?utf-8?B?Ty94K296T0h5TkhhcFZ6Y3B5cGp1RHlWc0UrenRWd3RwNXpTVE1tRVRTdXQy?=
 =?utf-8?B?aWI4Q1NaZjJyNi9FRGl0S2tUNTdtR0VYaHZVVFdUa3VEaG84NTNIRUVPVnpE?=
 =?utf-8?B?OUVtMm85RHZ2Z1dFVTZWUVJyZktsQ1lvanRDN2cxaTJTSGpDS3dldHJXNUI1?=
 =?utf-8?B?SFpMbmJyMW5tOXMwZ1FhdE5oYXJFTDVpM1Q5Z0xlT01hYldUbFh3ZzZyamo1?=
 =?utf-8?B?M2R1SFdzdDdyUURPQXhWQ2pQbnBpNTh2MVpGQUhlbFRsMTRoOU55ay8wNitY?=
 =?utf-8?B?YXgrVkllY0hvcDZhb1hzSWk2anhKSnhBTDI4VWptZDI2T0RTcnJUWHc3cjlO?=
 =?utf-8?B?dzVkMUlSRm5BSU5JSnN3U0E5dS84V3R3b3BFMWFMdXRFV0E0c2V3OVVTenl2?=
 =?utf-8?B?UTBDdzIxNXA2cnFwM3h2NjdLZEFWajdLRDk4VTk0d3dwVHVsTTdEVEYzVFF1?=
 =?utf-8?B?WUMxVlp0SWJlaUJlNDI3bVpWYUcrVWlWT3ZPQTJXTTFXaDlKR0t0RXBCbjZB?=
 =?utf-8?B?NFRtQWNGZ202SXZaRWNJRi8yY3VuODgzT3RvYXJ3cldXZGxXYzY4Zk1pbmkr?=
 =?utf-8?B?dExrdVVGNXlLcFYxVURkeDA3WkxmeWI3cGlUaVFrK3VGYThSdjcySjBqNHov?=
 =?utf-8?Q?OxaWdqwpwkZfUtQY=3D?=
X-Exchange-RoutingPolicyChecked: kM9kpp5XWfdnRrBAIWlu4/6cxkY54BqqeVlqOYtagMrngDfqaQfTklbagbx4RtS3oyAnpEI5guATnpU7RVvJM9YLK82vvazJWsaq9fECXbR5oCQuaisu65nsNJDo7hfm0zpB0a2aGQtxRyg4ZK1DQBELw6otFuQneoAJLa6Z4hqQ1NQ4f93mtdxBA+4aNKS1hS6c4+8/6Dps5VStvlkUkt+XwVLU4zPEGI0cVvdLWUB+r+nQlRz1aX8ZNW1HFjXFGfwfP1e3RYxTzx3zi1qpRD280bsB4i/qT1XQpzoFfL05WbRigTfFNoZKmxUbkSA2y/YmMRkgyokhcfYqfBMUUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fb38c9-8772-479e-8fae-08de844ddc28
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:51:47.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1usHIyQpVVO6TLjp6R9+NCuDnjduCC7PapOAddswRYgd/EL2QYkM854wV4jrGSoG3hU8huQcBPDdZeq2hg9WwH6XaN43WHOjwubtgPz8s7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9467
X-OriginatorOrg: intel.com

On 3/17/2026 10:04 AM, Chang S. Bae wrote:
> 
> referencing XCR0 on 

Oops, CR4 apparently.

