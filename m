Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA26364EA4;
	Mon, 27 Apr 2026 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312313; cv=fail; b=AplY/QgSLetOw+XgInA2nxIfYV/mEb5oBwrIw5NHWywhyOyuXdtMRvT5UFTBJyrInzwFg6EeJyqhpzTGUaW5eBn8hI194Zd3QaJJ9qLwmJnTWZYsfV65QZ8bi3D7kbLE1Svr2UEIrZJEfngVvRQoCLTFFM5vu+rTq6Fz5G66MeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312313; c=relaxed/simple;
	bh=HpIss3FUEjJxRlkL0vrnL6LskT3AOM9ENa1Via8TLz0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tbMmRwXezD0m0KnSKySvL15Oui3O0S6fZg+XyX2WGO0ta3xtW5DzV6HsTiWeucmWfk+TncXYTBQ9KGl9pFbf7RGt3Tdl2/kXTW0dGtwdSFaP5V3Jn49llzUOg/uAmLF9GKQ39067Vv4ELUPkleXSXqDl/iXRKjSmHPw8uSiCAyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIbQc4Rb; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIbQc4Rb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777312312; x=1808848312;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HpIss3FUEjJxRlkL0vrnL6LskT3AOM9ENa1Via8TLz0=;
  b=aIbQc4Rb9vRNWpPvGn1kGLmK+6Ugdx2io0kokgr09ZMJKQRUOk74+g6K
   +Wq4curw8LZqLqbNtaRBpN53E/juMJ2sPzbZAQC7Z359n+o+W1cpo3bYD
   vxVy4OROIFWHYVfTpig/gA0j6vs0O0/niNkbr6+m5esM7FlsggSDRF0Pl
   jTfVbtuoH2DqbJRvyi+0cT248Fery0WyeFRERL0Xqp9kki7C0L7Iavncg
   om7eWGppNw0zx/mP5nSA22ehWwamBXnZmNj44wjgg0kQN2F1eE4YfVnGV
   Jqs6L9AfNG90H79QGs9LnEwMGqv63K6+al1b6nejoPxoXxBeS/hgetBPr
   A==;
X-CSE-ConnectionGUID: Q0gnWkpBQlWsbPfRAF7OCQ==
X-CSE-MsgGUID: yl5Moja9ToCtfcZ6xTNnJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88810732"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="88810732"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:51:51 -0700
X-CSE-ConnectionGUID: DNJnVYrjQzav2Gifi6enDQ==
X-CSE-MsgGUID: 6BsvRsWTSmCcnpRS37y/4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238689473"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:51:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 10:51:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 10:51:50 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 10:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwKj6Q7isHH84BdxqPQlnUZc1cuiphks3jKOXql1d0fLcLneO9XhSYSnIZb083q+uhL01Wkb2iI9xNzSgTzYrRzXHHMdsBDMzKh2C6C88JB32m7p7m4cC5dDNxLsVCBR3AGaM6KhAK1XqI+7S6prfvvQWoVqXuUtnLv5csIeEtp0/eAsi8qey08SS8bqn0QVd8T0gnVsPLHzLyqDkoFkDXf+CYjBzogG3Gs/CBkt648P+GgP+Q6hWgDFWc0Mw6IX9vQIzFlm6FIIHSi/n9yMBsatDIXZ4+J5bqzKH1dOsS+CgOVgErSTuxtdKv+G6AnNoq7sp9VG+X7hHHzY60onJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0JzCijVQXQ9QzH5M/EJNqtjgfrhnYPXNmp5mPdXveQ=;
 b=dfghB1FKvPfcr29N8E69aJbEiILTHjYt81xvTIxLoNhMoyF1BECn+6tEnWnBP8KX8+k/qcIOb+mbHkGZVQM0VKnd8LjwQimT5nSiNn3SpXaTnu9rPBObuQMn9KNb19hdpKIklOsvbZ55WSg1KfX8kP1I0wikMG4W8TNj3BP4j+6R74dGe+TDOnWO2yLK7Wgog4GSW6sgaAeSaGJbz8BBV6Xp2+wTslCJn1Pb2FupWw8b9Rb5MM71iCQunI0iWLs3YEjPR/UscOKZThjS9+JlUYqw7w4yb+b6OLM35bu102uSLGRh4UU7hLh+Fh6XkxKtUrTh7mHZByl4GZBWlOQieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.20; Mon, 27 Apr 2026 17:51:40 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 17:51:40 +0000
Message-ID: <cc2f3023-ad9f-46be-a6af-23f829e799f8@intel.com>
Date: Mon, 27 Apr 2026 10:51:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] KVM: VMX: replace vmx_spec_ctrl_restore_host with
 RESTORE_HOST_SPEC_CTRL_BODY
To: Paolo Bonzini <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: Binbin Wu <binbin.wu@linux.intel.com>, Uros Bizjak <ubizjak@gmail.com>,
	Sean Christopherson <seanjc@google.com>
References: <20260427105848.44865-1-pbonzini@redhat.com>
 <20260427105848.44865-8-pbonzini@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260427105848.44865-8-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:254::13) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH0PR11MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: ecedaaa1-9275-41d6-007f-08dea485a29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TAsCDRVuU/lw+z8SlD/m0xJH3jJ1USoDTJpZIV8vaqqns+tKccfaM6Bpaz6vNxKn4qrS98morvBwwDEFdY6Wrgg4eWuls+B/K2EerqwmPgqXsYBWh9vg5Sqqe7IW2Z2IJdcawo7SUviRVyOemVtlZIy3rxhMZ/GSf/xWaqa/OB1CmqW6Q/piFxXv515/Cmx3dQet7aTbQlJehkqb+AvqpeIIvRoYZZ5HZd9jTT8y2/TUXeFANUviL+q7LMZ2UPzSBdlc5vwJPUqPyMjH+tQkMFxPASHp9NuwnF8hVWlkcz7H7qi1y12mhuSKfS9rIrDadpCRinlE75maDQ/PzvKg2O1C+fC3ATDg5Iwu+3JBt9kdCe3Ij49jJvS++omwqs2CMK2mKMJ5dlwpVfsPEnmnoILq851LH5OuOxrPILhwARkjCNqcF1XVzL4x+LPUNrpwsqmoBfCt4JB9PPa5tv8rg1YoHNIiH++4WtMr+WlDZhJtp8U7IXQafZHR/IDwdXicd54ErtR4DIIzDiiepvXxRAZwOHyzeQiVpo7j+vNjdr2Rf2e4DoFVn6m4XyTrYxKhXt+ZVVezWqZoPSm7uWKbQnkI/5gDId3OkRPEnXKBM3ojv7des8sX8PkJK+NRk24BV+KszqkjjOJOXu5ksjG0hMz/5IDpQExGfT6ckwSaHStVcAdBiEaCto2AIRGgYU0joQaFODuZCchTFSI/DHUPQjEEQaoD6ILA7QMnMiHS+j8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmF5K205S1pRVS96OGhlcGRKTnFCSlJ5bWdDNWFjb3U5cnV1ekgxbmsyYno2?=
 =?utf-8?B?TWJSMWxUUDl5M3FwUzRYZnlJZkUwUGhhcmlERXk4c2lBRWxsczlGR0Yvdmwz?=
 =?utf-8?B?MlRndlU3QlR5cmpPNGhXdDJ2blg5SmxnT0FwQWovMkx2aVppVmxKUnRFM3RI?=
 =?utf-8?B?UU1ZS0tudGMwTXZIQlVpTG5ad0NUL2g2N2VsYnlrc2FoWHJkK3o2NlgzVjF1?=
 =?utf-8?B?MldkU3g0Zm9WVVhEQ0F2eHNpbm9EcXdSQjVRSTQremVwU0E2M1FrVDFoUzRY?=
 =?utf-8?B?Sm9BZHM0YnVJZmlRS0NzUE1HWTlrS0U2WlJIRVd6cFJTN2l4N1l3d2tKc3hD?=
 =?utf-8?B?RUg4RDBzNy81QkFLL0krblpManZjMitQalF6SEJaaUNyU3MzR3BXRFpCekF4?=
 =?utf-8?B?bmE2TWhYT1ZreUZzOXRka3puVW1laGN0N2srT2V5Q29wTzNoYitPaldPRWZB?=
 =?utf-8?B?dFBSU0pnc2JYQm8wZGlLMlM3NVZKMjFDbXJhSlYyVGhlRHpvNGIzRHp0aE5w?=
 =?utf-8?B?RmR2VkVzUUxTRERyYjNQQkJXWm5hcmhSamxMaWpZa09XRjUvdHpjVG5tbUh3?=
 =?utf-8?B?MzVzTnlKYTV4TEx1U1YyOFloYjhwZHBuc1FwbElURU5LRDV0c0tndFZsRHZX?=
 =?utf-8?B?U29LNEpINTZjM1B0b0VLZE1LbElRdnE1UHRJbWFZb0kxUHJrb1NCcndvNGJx?=
 =?utf-8?B?VjV2dVhaOWtHQ2lObHRzODA0N3ZPMysxR3M2NnM1OGdSb2w2K1BTdWlFb0lw?=
 =?utf-8?B?NXBUK2lHbkFtVWZnVlNxZ1VTQU5kcWE2YTI5dTRsbmxKYys0K2tyeUlhU1Zx?=
 =?utf-8?B?M3A3YjJzS1VxYXpmb3p6ano0SFcyV01BVk1md2xaS0dRYkNSYmNCWjlySGRO?=
 =?utf-8?B?K3Q2N3JXSzlQcHFTaFlwbUZMSk4yM01tTEN4cFl5RHRaSzlDMFhCZDJ6ZGFJ?=
 =?utf-8?B?VzBaZ0p0MFpYc0tLL1ZIc21wT1dxdms1UC9SNHc3ck5qbW81VzNBSDgrdTMz?=
 =?utf-8?B?MzIrL3A4Y0pSL043amx2dlBMWWFDMzdUMllSb2gvbmZiQ0x5WXFmUWxTb2xQ?=
 =?utf-8?B?ZzVtREhzZDh0MlJ5REJ0enRZbzFyQTgvSkJXRmNoVVpvMEJyb2JMS3ZwRnpm?=
 =?utf-8?B?cEpwdTFoWWFueEFtS1NUN3M1cjJGdnM2ZHJBejRsb3JCZGZKN3labHdzQkJs?=
 =?utf-8?B?UkhmZ21YM2I4YzduQ0Y0NXZqcndwaE5LSHUwQnV0eWh3RFFtdm9JQ2ZIV0Z0?=
 =?utf-8?B?TU50bUVvMHIvMEdXYXJhaU4rM0poU013V0hxRm8yZGxBN1NYdHo0MmtId29R?=
 =?utf-8?B?V3BCVGw1RUEwWEFuRjQwYWlxS2V3UTZEeTA2ZWIxNUcrMlFicTdXSjBJOC9P?=
 =?utf-8?B?UkJ2NGtKZmxBYkJNemdLRllwMlczWHRIWmtwNERRZG9aeE5DcjVpc1E1eDJK?=
 =?utf-8?B?UktxakdmYmdBMld0Nlo3Sy9pTlV4OUp5TmpSWGZ4KytycjlpV2JUZGVlN1M0?=
 =?utf-8?B?MUtScnBrNWRza0dNTUsrdityU3crdEpBOUZ2Y0lkSjFxUk40WFBNN2hydWE2?=
 =?utf-8?B?NGcwREtwMFpSQmJhNHVVTWk2bW5JZ2pQUWZJSFdWbEgra1ZIZDRLNTgvVll1?=
 =?utf-8?B?THJYZkJUcnNnSFFBVmhqUkRIYnlDeU1NeVlaUEpUNWQyckp1QWZydmZWdzF3?=
 =?utf-8?B?UmNxNHorTUcyMHJVTk0rRXYxT3l6QmhYTlBWVS9tcEZHTXpFUEJxTks3UlBH?=
 =?utf-8?B?OE05L2E0bnUzUStmMEdBMWliUkdUM1IveWdtak95aHB3bENHNlE2UHFmeUNN?=
 =?utf-8?B?Y09UN1Z0elIyd05oc0xMYXFKWG1YMXpqS0VERnlZdVZQVUp6Z3lVaHNTZUJr?=
 =?utf-8?B?M0xpMjltU0JzZUVEQ0Y3NVdiK1p1b3NFMzFjb3pEYWZJOFZZWkw3NlYvWk4v?=
 =?utf-8?B?Nk1GWXRwbkl3QzZEOFpzUDd2OTFESnFKdkdHTHVJSzVWN1lESjArcFpRcHpu?=
 =?utf-8?B?VUFFZlpmNlJwOVhtVkdEb1B5bzU0aURkQ1BSdTJzM2tYMUZ3UTV1VTViOXBn?=
 =?utf-8?B?eTF0T2c1Rm44dlZPUnAxODRXcW9mRUFvZGVudU1uSHBSVy9vK1BLZENmY3JF?=
 =?utf-8?B?dGszTTY1ZWhsL0p2L2IxbWkrZU5JcDIyMStLdDNubFFid0EvbHRtUm44OWxJ?=
 =?utf-8?B?Mk84WDNtZUpyUHV5L0EvWGQxVk4yYWdYditONXVReVZQYnJmNGY5OG0vSlgw?=
 =?utf-8?B?aEN0WC9WZnY5ekE3czNZQmtZK0pqeTUyWm5HL0FuSEFISGFHaEw5S25CVzRr?=
 =?utf-8?B?NkJGRDNSbmsyZ1NNYU5pa25STlROS1F5RGRQWHNqbHRubHY4cWNtdz09?=
X-Exchange-RoutingPolicyChecked: VNunUzrQmtkeScAxX1NzTxGVHgPKM/u8lG37WiyK1MYDe9ySiM11jWjgmp44bqHWQvzvPxZiaWmA0SPBHr9ihCnZO26bulk3FJ2+U6S2xI/5xw1eTxaagfN8suKdPlRaHbj4QxnMO2j6lRB20NirHhnglW30IhFvU6PqGKqpz1fRJMy1k5Nt2wtHk8JOVMpR/HNe1HXVd6G1e5ZhvR4PmNvF+2uJgknqG+zEdtxxPwEFHvZNaK3Y4O41XWEparWnBlkPjprQBbN50yITVnMZiI+mtmzIKCEAEZud7GLa6Z0HxyWoBR4JO75OR2+5nqYzZ9tPOU9H/AumNDX/RSRmbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ecedaaa1-9275-41d6-007f-08dea485a29f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:51:40.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8rN/kCRIsM0doPfaOt14UPsa2SRX2wTA/rSRpF6crlqTyLsYtpgy2Ed7TsMv0liqsecXD+ZINksa7LR4W/Xi0K9FmZR+E+7E9NO4S0FSTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
X-OriginatorOrg: intel.com

On 4/27/2026 3:58 AM, Paolo Bonzini wrote:
> Reuse the same assembly as SVM, just with alternatives instead
> of cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS).
On guest, do wrmsr(MSR_IA32_SPEC_CTRL, 0). Then, checking from a handler 
in C code, I found host SPEC_CTRL was restored.

The case also works with clearcpuid=236 when mark off 
X86_FEATURE_KERNEL_IBRS.

Tested-by: Chang S. Bae <chang.seok.bae@intel.com>
