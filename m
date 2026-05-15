Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37C221F1F;
	Fri, 15 May 2026 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778810672; cv=fail; b=uOrEFuS74ENsXilzfC8tIq+YaBn5ovdOHazD86OTetmwsnCnk5r5LFsWIozms5qXd9yigh/q+OHVEJUwVEnB8urZASC0AJ8Bag/WxQTLyB8ehkSt4uIl/02Ll+GCxk1Mwr8FdcHlRDsU4xBq0VB0f6I8sMkxhFFtvrd2yLhEjI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778810672; c=relaxed/simple;
	bh=xUuiBOKZGN42S/DKqpUTjp6IsQMvVxPTOiXjk3ZZyls=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLiKQJFkAdVtwsbLMSOil8ay5U7UXJ89XZY/kmNrP9tk8j6hG5UO2YK6U0QmkmBr6wSchqgrNLyUaE4PrW/4SrTgivLXhffkx9kTAyWxI9xg9s0BAaD1NdkKVHSNmv3xUhI4OhqWBUxspivLNFQFYlFjU85ggkBgFn7ZW0K+Erg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bl0490YD; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bl0490YD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778810670; x=1810346670;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xUuiBOKZGN42S/DKqpUTjp6IsQMvVxPTOiXjk3ZZyls=;
  b=Bl0490YDL1XXmQQcIp6qKbCmyNbEEUKl7WMrBsxY/QJQ46RP7vZiUMAI
   pbmFUAzzmdzZDpxuwD1yyZvH/L1wxQSbg8biZFPU3jn3lEE7XUJ/IhjlK
   YXE9q95kIGYnDvGFb/bxnDMJL0N1iLIcvUDPUVtVICeurgF2Y8zj9QjFK
   7VgQrhxg3PwTfXxYgpTtzMLwufm8wZwWmYQoOBbWqKM+rJ+LjgjIT+Yls
   X1knm3ux1ZmuyG7qb6QCiZ/7Awy7guoFOgPEJrMhG5Ff6m3I/cJzc6cmX
   ieS8iM6k/lAhd6wQ/e8s+miCGld5VUtTP1b9aJaFRC4hzTXuiBwlcnkSb
   w==;
X-CSE-ConnectionGUID: /7puCWuFSLeUTCpVbxRZ5A==
X-CSE-MsgGUID: 1CxxIGFDSBiqzxM0gxZ5cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79656342"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79656342"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 19:04:30 -0700
X-CSE-ConnectionGUID: 4D1esgLwSmaQgCCn+322Tw==
X-CSE-MsgGUID: GroohtKsT9ieEEyQ/UTiWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237695043"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 19:04:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 19:04:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 19:04:29 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 19:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b60dACds7yk+MALy+0Rqg2YFEHoP3ZIaEgEqpwZUBb//FrmYGWwl+65mOFv8W/UniJ3X3FnnHeLzS+t1Ob8afzjcckZuwFViWcG5QkVs7excKZJc2gIwRXd2+mPVkaVXUHsmm8sh3oG2JcdwQJuvNoiBFtqUqYxZnzeA4QDPx5+qSNQHhyIbuq94KYhwt62qBdD4u9dGNVjQEpSG3pWymNk7+8GtngzGVCNUWVJ2ZwOjFpcG2wit/CaLNziJIlqT3gOIbU//OAoZuR7J6ED1xaK5UhWHlS7RxtFGDYAlEgViBUNc6fomG9JJMdQBXEzNbgMHlDx5UeOCbmn5o7ZJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbsUODowPXBTG1yVYpKjqGUPiaz9VFXS62itwP3DCA4=;
 b=eIWkR1fM19iBuPnTlWlpP+kuc5QF2zjCqXHdIqcrL211z/WB5H9cWtGN0gyXtmAoMcY4sK4bg1eB82NONxZHi1shXQSiHHL5JyP9qS5cO6HkVtZq43ESnNc+gPxzTFLEx7r5Bs2ItBf/zJIxbyxXTGGksHHuuniD/E3R5wMTNsK0Mu+d9smX6hgk04sxXjdkhWLzNJW9D4T9UzIBcWnqtdCvHUYb48rA4MGt4lnJwD96NKILW5SZOSuX6MZLEAABJo+UC3pK/52alLtyJWrQCYcoumdIIItPg7XZPfamPo/LIjN0nzN4ESpQq9jEqPa60PxRnrjgRfPKlIeJ0P974w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Fri, 15 May
 2026 02:04:21 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 02:04:21 +0000
Message-ID: <cef865a9-9a15-4ab4-b137-085ab3bfb7d3@intel.com>
Date: Thu, 14 May 2026 19:04:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <x86@kernel.org>
References: <20260513174948.726812-1-pbonzini@redhat.com>
 <20260513174948.726812-2-pbonzini@redhat.com> <agYi2Lc7UbGiw_zL@google.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <agYi2Lc7UbGiw_zL@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA2PR11MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: df9f54bb-107e-472e-8583-08deb22647a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|3023799003|22082099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: /zdtE9FagBgFHLfAIkhYVx2argCpzIB2ZCcBrOn9jm6/SwKZJPoeF8JdpvClRuRU8CXQL0vfDWp450/1l1Lmry4rH8sPI93Ubbu4BV+bXAIYaBM80679GiE6Pi8pFZzBr2OTTHrmOo27F9npfmQ1uOhR/m6JNsOnJ+XSfKXZ4sPUryZ7x43aW7PSJ0eKe5bE2Ajoxs5ZtWrtcktVYXlTflUHQLR3IRI+HgCyyKS65fEF/xbfUIMbmUZ3UHQE3PcyqZ/MYyJfOl6c0BzXQorHjG1umKixGf9f18GYO81OFCIZPFi1W5LUBP6cItFLSLDyHrNI2LOlV/Aw4KLNl89Q2Raxcm6uRu1evQ8IDLpuTMU+kJHqRp85TzBMFMnH/d8/BdbqPeofSEOpCu+jKLbsjHR3gHtkRQYsglcRzKvPt60CHxqXMD6unROQmXad4a7mZPi+a//jJJceKValC5O7GhcWswM4ewlhlCBjQ7HkK3ehJiZj7x22IclDQ83H7fHJUp6+2NH08Gp9SXjffm2M3SNMidFDl550mvl1EqnvQL8F/NheAXEvrX/KhBSlIRtzzKlcJcx9jfmxN+rhFiXC1nlKL9hK0mkgjwcIkWNeecYgLZn0fxvjlq6ryMTDFr+6UJepNRJ+ckyrHrbNoD1vIVUACHAikTuDmFj9/hgYFRUQUjWQ3JaECiuQJWD2Vi5v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(3023799003)(22082099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjlqdnVNcEovMG5KNE0yU3RQTW1QWmkyMjU4NTVFV0M0VDVlVk1sckcvaTNG?=
 =?utf-8?B?QllVVHlyY1dRcHYvbnZOUlFPbTdwK0Yzdy9QeWZ1eTJOcksxS0QyY3BYaENy?=
 =?utf-8?B?RzRlMGo0VWs3OEVvSDZDalFWME9oRTBES0VRYUdNU000Q0h4QTJNNXFJdmVD?=
 =?utf-8?B?OG8xN1lHOGRrQXZWMFFlZXVRZHU0YUZYYnhEcU11dUZSdTVpbHJHd3BxbFVS?=
 =?utf-8?B?eTZsSEhWMDJrS216U29ZdG9iMGFUbWxTTERTQWc5USs3TnlSUzJoRVlBMnVJ?=
 =?utf-8?B?MForRlZwMWttT0psU3lHdHhEODJobDdpQ1VPREMyNEhaZi90eXhBZE9nSU1P?=
 =?utf-8?B?cFJFa2lJdkRGK2NUbHc1YUNMZkp3Q01OUU0zVW1Ub2ZQM05hSTNrREk5WjRv?=
 =?utf-8?B?VWFWYzA3bS93ZCt6cXFJdDhGOGh0eXo5OUsxNE50UGFqYzRGLzRJQjV6VEZF?=
 =?utf-8?B?SFpXTVRFVEhCNHlCb2tBdzdwUkwvdElzTGxwQW9SWGVXZzlhenhnTk9WQ2Ju?=
 =?utf-8?B?V1hPcU9JMmFoSGFRWTNTNjV5eTZNT0RHRDg0WjZXVUVYN1Q3S1pnU1daYlY3?=
 =?utf-8?B?N2dUclZhZ3QrUUFET3QrcmI1WnUzek5idG1ZLzV4Ukg4UFQ1Si9ieFQzVitW?=
 =?utf-8?B?eklVSjNEYWNjSkpMaUVYcWtrY0psemd2TThOazA4d2xCMDBpWW16SkdxcW1R?=
 =?utf-8?B?S21nMXBCd2ticGl0THdFY3BLV1oxNys5bWRBZFBqVUVEZFkyMTg4VGtXL21U?=
 =?utf-8?B?T25FZW01OU9pQ0I5WVFVMEY4REhLTGNxYlJtaE5Jc0ZMWGhSRHNNLzJNQjBO?=
 =?utf-8?B?ZUV6Wk45Z1JXaGd6bVBFM09Jb3pXZzlPNXVYdm52RFdiSVVKRWtzWUFzaHhi?=
 =?utf-8?B?YkhyZWd5NjMxN0QyZEpXOWxJSGcyN1lJbHRtdUVFbERtUThya21XVjNIMnJ0?=
 =?utf-8?B?NVMwaDRtVkgyVUpGYmdiWnNRVHNrTHRoOEFlKzdJdGpJbXZRVVFQby8vNG5y?=
 =?utf-8?B?N3ZPZ1h5dXUvYWJydUk5WEJLSjRGVFB3ZnFTMEZSUlNKWHRNaVJyeXRnWXpv?=
 =?utf-8?B?T2lVN0cxQUVrajZ6cWVla3NwRUd5cTR0RGVNUDRoR2NFTDFLWVRqcnR5TkQ2?=
 =?utf-8?B?RVMyQTNmSUhoVVE2bWNTdXhqNW5VUlp4YXBGL0JscVNIVFUvOGp4a0lKOVA2?=
 =?utf-8?B?MDJHZFlITGxEU2hYQWZMMktxcDI4TWEwWkpSdDZEVXg1d3FYRG9yekJkdmlR?=
 =?utf-8?B?L1NnNThTcWpMbTJTUUE5TENWb2xPUzl6WmE0Zk1TS3hnVzdxQW1SWlBWb2pj?=
 =?utf-8?B?RlBOSVhkMnJGOTU4clM0WU1qTFJjc0VrOWg0UXV4aEg1YmtWeEJPb0hxeUVC?=
 =?utf-8?B?U2QyRW1jM2w1S00rVmpGNXVYQ2lJZzhWWkQwdHpwd29kMW1BQ3J1NkQ4Z0dl?=
 =?utf-8?B?Tk5XeStqelNHSzJONk5EbHVRVkJnUUowS2x5MjFwcGZueGFweGh4ZG1LUHNr?=
 =?utf-8?B?c1M0WkpKZWVVbDlJbVh2WERsWndhY3NjTlJWVVVwVU81aTM4TGdKQjhYaWZx?=
 =?utf-8?B?S1J5UnFrM2IrR2hjdktKcFNBYVdFcnU4Unc1RmQ1RnRFY29BeHljaGNMTmJB?=
 =?utf-8?B?bzRDWExVakYzQnR4V0oydnRJSlcvTjRCWXFuTU81K0NFM2VDOWhBNXFOSHgv?=
 =?utf-8?B?ZzFwQmx3K3NFY2EwbUxMZUcxRmdpUnFwTUdlTFVZS1R3QzZ6aFcxRDNYb0RQ?=
 =?utf-8?B?alpUQzk2eExjenkwY2t0cDhwN2RhR3VWZUhhekxSNGtWSHFnUGUxMmJ5NEhj?=
 =?utf-8?B?SGFLaEJ0V0Z5VnZpMVhHZU5IdnFHb0dKYmQ4VXdmRHdJZTFVY0IzY1NJcE93?=
 =?utf-8?B?NDNCQ3JIbjNac0w4NGszOVVoRzFZZXpPWjBjV2ZjRnZsck9EdG9PclpISmFR?=
 =?utf-8?B?czI0UEJWNFNVVUljRDZmZkRKamxObUhsUzd6OTBpdWlpMndzYjhXaU9LRHUx?=
 =?utf-8?B?WlE0enJUMXpYbHRCcmg1MzhIdkR0OUZaTEQrd0pRZ04wWVUrOGZXNFJXb0Rv?=
 =?utf-8?B?MGtnVXZxWTZVUlN2dloyTUR2UUZML0o4QjlkUkt4SGUySFFaTTRoR0Zra1I5?=
 =?utf-8?B?N2g2R0VrWUFZV1cxemZBWHArOXZLWHUwOUkxWGl6YkExWFJNMHBzL0NkR0tJ?=
 =?utf-8?B?YVpsdk5jVlhHWFRLNkxCcVdtS1l0L3BpOXdyVEhlT3FrN2d4cXJrVkdCS3Nr?=
 =?utf-8?B?d09GUHVRV0xmcytveDJ0NHkrRUlJTHEwbkZ1eHh1Z0F4MCtHT2xDZm8rL0E5?=
 =?utf-8?B?SUxQTFI1ZXdvM3JlbVVDTDB2RjZBVFF0NXRKaXhubWVXNXk4UXhjZz09?=
X-Exchange-RoutingPolicyChecked: BnmcyAHxHB+ScBJJcTzuk1ZcAiUpfv8Z9UxgBC5vH00/mGXWZ4JXRsWB1fh7ebsz9lYaaYlwnbbcl2q2dwqvKgC7OiOumHpcCynMuTyTy0TFvmHoa7ap+UPz0V4YjpIwvbRXFdbqnnnpj4i/KF9mpwfpDNLswRgI+QtwUUbfTFKuN1N9WxXMmSB4uCb2+cBbE3cfSFkviXHViaqHMpRY5U2Fmbd81sCA9fKxkyks7pq8IBvd1LITdgyzjxZJLVHUZnDbsBHl7HQTYdLcUZmlmW5u14ZOfUpOU1vE6GExs6td+MvmJ9XfZUseECOdPMrwJPybh53k2dIWqpOVTkAFVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: df9f54bb-107e-472e-8583-08deb22647a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 02:04:21.4461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPzWKD9j4pgndKEgBW5MSKx1GiwrPGI16sHLy6ayeSTpVXxMEczwf4kJz+11xoDvUN2BBzmTUzy3qs/gi5DvnZfezveqxEf4m0t6ZF3wves=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com

On 5/14/2026 12:30 PM, Sean Christopherson wrote:
> 
> This is not simpler.  Maybe it ends up being less verbose, but I don't see how
> anyone can claim this is simpler.  E.g. for people like me that aren't already
> familiar with the .ifc directive, the R32_NUM macro is inscrutable.  I can at
> least suss out what e.g. LOAD_REGS and friends are doing, but claiming the code
> is "simpler" is rather ridiculous.


Intended to abstract away the repetitive sequences. But I can read your 
reaction. The compressing macro hurts readability, especially with the 
nested macros and directives.

> For me, this needs to be the focal point of the changelog, and it needs to be
> written with --verbose, because the impact of APX on the VM-Entry/VM-Exit code
> isn't so obvious that a one-line "this makes future life easier" sufficiently
> justifies the macro magic.  And that's coming from someone that generally loves
> macro magic :-)

How about this?

   Convert the repeated register save/restore sequences into macros in
   preparation for  extended GPR support.

   While the resulting macros are more compact, they do not necessarily
   improve readability in fact. They rely nested macros and assembly
   directives, which may not immediately obvious at first glance.

   But upcoming support for additional GPRs (R16-R31) needs to extend the
   VM entry/exit paths. Continuing to grow the existing open-coded
   sequences line-by-line would be increasingly inefficient and tedious.
   Those macros provide a more scalable approach, despite readability
   tradeoff.

Thanks,
Chang
