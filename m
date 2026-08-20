Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1A367B67;
	Thu, 20 Aug 2026 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787195841; cv=fail; b=O77iZz3QibBvY8as//ExbtNkWZC6sfh936VSoEQZQYM0KdU02vbqMY4De5ePjZVKH+Egq3Rj7lpCClDGxNDtuiUyM0pHumDgtvR5kxibOGr57OnLtzLUdZS0FSIcOLz0d0oPAL0E4bDZiZeCAbKU6FHtce4i8t7ES0WNWavXJzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787195841; c=relaxed/simple;
	bh=BACBt0pAH+ohdRomG/MmfU3/PKUAKalT9D9sml+kqH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AJYjqXHDFY2uNh4tTgo7BfD+RUfVmIdU1Ddwfm8X+ct6TLPr5NgQPibbiMO7PPT2w0urJTs63yjAkIryjLMkmW4eh1wxCx7bcBdcU666AmHrjXOJpG3vV4La79ToIdtlFygaZeJG2ecENKC5xYKjZwvu3RpjN8FkKn4sSEqd41M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcQms6m6; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcQms6m6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787195839; x=1818731839;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=BACBt0pAH+ohdRomG/MmfU3/PKUAKalT9D9sml+kqH4=;
  b=mcQms6m6tlk+SPVvoc494VYUJKe2pHQNC/bEQ4fRYTap7zfK4xhyDrGv
   w0nALtOQ3jBWbii27bqHmiQbjwocEAe6SGI6xg2JRpMWAx2ufYPT2BdFj
   TSVVzye6lb0WNLwhK5+h0a0logmm5LRx1/xuHSQlLVccgmRliKXSbOAxW
   KMk69wB7VQxkZS1/Ufd+kgItFPhotw/HbmPuDPbsiuy1K8mGOq9nAva2L
   ySdmmSSp+br5HBrQFlNMygE7m4vRnR7UUyAut7wdtYmg70JjSiuoYTtkx
   bowspVwCGjTYt6FB6Vu4P6I81eGKbP+VqhZqiBNrip1l1M1O5JfJNW/pN
   Q==;
X-CSE-ConnectionGUID: 06+LI6LDR8urH44UrIEREw==
X-CSE-MsgGUID: t4NOqotUTP+iquqZClp7Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="75253592"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="75253592"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 20:17:18 -0700
X-CSE-ConnectionGUID: y9kyV+hgQNa9vVzieoMBSQ==
X-CSE-MsgGUID: Kr96+8IJRQuTL7QNqm+eQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="262009790"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 20:17:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 20:17:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 20:17:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 20:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBqhaGlrBRXY/iF4RNRhjvfBWjR447Ti67sAr7z3VuDMtmxQKmLHUurv+zoiFQB4KkEjnQqQ5vUMiIfm1fo9d229/VvVUPA83Jl+MDbCNENghERhkUW0CTDCZBte3tqg08jTN7i12i34COWvQaUvOyapCnGaat80ZKJPgf/gF7pbAzBVkp83FLUzPEVz28uFc4XVrcbD5RzGO9RnYND1O4vJbDifS8RM+2jGV2CPMmg6Dj/kdy3lW9QaOUQZaWd75OXipYQ+iP+SijacRaeeV+Ow98JAmC7Ciz9xhcLlAmACpjgHELL4u2DKwQhZwyIjrhcq32Qt7NDVKfc4EE+F/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zFiVBMMtONon4FbeFHLDhpbiyjXPZSLSfOxqKPVT1Y=;
 b=wBAK9ZOn3Gri6bgnE1RVXu4ZjWl8L6936A5bgOumFTJQdTJO55yN20pZNPNXE+oOp6a82KA8pO2HoFN24Kqbr5V5+CWUV6fqFD1I63bnJezSTwjW0X3d6/Uwq6gQz7Sj73pmffg/9+yEP2vYa3VJ+W29dwtYdUL1zLf1wt0HpU2wPOQAR6uZTFzCuHs7dsTRQsErsmepcmtN7oI3jhxXMDylPDbkBcB69mb807Vk2Wt6vEOvyjLPhb8GJ6vbggqGrpB1LsasKEVj+q/nbLVgjAsuq3TrFwqYBo2mB+iVQSKhllhr/YRQDgpZlsOQ6T8NtGJhqduFhkYeODuAesOtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by SJ5PPF12B0A4A9B.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::811) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 03:17:07 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 03:17:07 +0000
Date: Thu, 20 Aug 2026 11:16:50 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang
	<kai.huang@intel.com>
Subject: Re: [PATCH] KVM: VMX: Explicitly track TDX VMs' root level instead
 of guessing it from CPUID
Message-ID: <aoZxoiFUqY0eu0ei@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260814224509.2342760-1-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260814224509.2342760-1-seanjc@google.com>
X-ClientProxiedBy: KL1PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::14) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|SJ5PPF12B0A4A9B:EE_
X-MS-Office365-Filtering-Correlation-Id: cf55d34a-bae4-42cf-3597-08defe6983df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|56012099006|10067099003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nd1pyWr7ilhP1o/zHsBU+5VgyodAqLfW2UdTG27pLrjmkJPNm9S0gzJpHAoyC2R+xaNmGc3FnC/nwniDfBagHyoo4pPOgcJ4pH1rHpommEQ3uwpvxZZW6O/RPYBhG6rDKHNOCftCSFFiGhqgmOEQsK7yW/HU+xiFf6WdPK8kHRZ5GJnAS+umd3qKZQFWLZ+Yp9cVE1dWYRyd7LgNlzAJXNGaqXcxRRc71vBa0cVlt68p+KlesoxryUpm1MsuyUtt1iriIonkPc44uhSgP/nImQ+OFJI9BEHFm3HJvhXxMN9cP7CRr9UHfVqu4c4ILPWsnNYRCqDbN7kq+bx4+VQsaBZR/OQzTs02iNx0wXFWwARms4qONAXUmhMDqMOQ+XCZSahRFi/69fB5ywIEVexix45Oa7gTbMbg5pxueljYmzNe4EHvt3xumY9DE+J5WunmlBYebt9gDxqjAIyGPuwn98bl4FHGagP8HcO+zcQAhsIaU7XkqpOb62oaCVgBZfwKltezQwV804j0ZTkT6uqfPfADB8AoPc3UXg68wH3SoMLtVFc0w/RukNgwI1nl8PMQkW2cSokaFL1Y8+HICblKsUdaIHBU7s1Ls+169hy8k7lAoPQcyjBoADRBopGX5ZU9UtWfUdzxG+F3Tm/hp1oAjMJui25vBtajSlIcGpr2iOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y8yRAeVzQgDELgFLfyogm8gHEmEr2TaumaHMY9KUYaAI1onFyIfih0FguWBY?=
 =?us-ascii?Q?6IbgF6lCGhe1cPDsZCbeBrIdnHg7T57sNw1iXc0BUY1mVoKFWCdMa06vY+lL?=
 =?us-ascii?Q?nI9FBakVEFuaQEFIMZGJUUeXcpaM2IpQu5RMHrgC+gQXUbpY37ZwGb0U1LTQ?=
 =?us-ascii?Q?RbXEn23j2CPFFbpdCShw8enwWhcAwLOXXoXjEo6Trr1KPSzpNRlwb7LLdK+F?=
 =?us-ascii?Q?xoFyvOAax/7kxrZgfkvODBlf7/X/LtiMr672MJnIHejlp5G1gsJ6QI7FOZFh?=
 =?us-ascii?Q?3wIvabAIkDueLaOWN/KyQNEUOXRFoLVOYHHKMeWXi7CHcXWEenFFsCFO6gfH?=
 =?us-ascii?Q?jGJlNHLdKCU2/hpZQU8QA6cYESxuC8UukfunAeT0FJok/HQKwu/NIA+6CvJA?=
 =?us-ascii?Q?+jjgZ6Mx6IXemzoh79osbFVDVwbeXBZy2YjV6yb2z8sYil65RGF+xN94kHsB?=
 =?us-ascii?Q?tflW/E93c/mRNqqTgnXfcZuLkhkoI3/7llqWTAh90xoGNpDN6nMLIBxJVCrs?=
 =?us-ascii?Q?dSwSEK+d3ANyWrAdrGVmEgajlUCKoZJ1FeoNSMMis5+p/uDLdqeddf5abyOj?=
 =?us-ascii?Q?9DWVYX8wmQaEcayQArFjhVxWQYQmc+gW0yb7anJ3arg5ciVD70pvkr89aIXA?=
 =?us-ascii?Q?/vS05+4R92egmvPvIKb8yA1UHLRPdaUdgUA+RtsWOvvK+6buaizGrfFORZYH?=
 =?us-ascii?Q?PvDXtjws0XNPgOa/DYbxe+wX+BEmiynPhnnbE8+t0aptEHsqjUsf4ssbGQJY?=
 =?us-ascii?Q?P+41HRBGlVEL+PMQ+PKAx8MWI0HbhTeWmiRI0BuS+MRBumBbQGNWhCfSGwnc?=
 =?us-ascii?Q?DUSKZJiFX0rsPR/r1EzHii88Er6EefN7KsdEd5ryMDQeBmCHQOv2fgs6L2t5?=
 =?us-ascii?Q?d46aNjk+cqR6OqYidwL7sGxVutxQK8YgV6Crh+YlRqTY5LEIqQI7cdFm4kZO?=
 =?us-ascii?Q?bjEPQCPIUFs4wtGOmHN2VILfjmSfg6n4DwYNT2ro129iGQE0BL5QwlH2BkVa?=
 =?us-ascii?Q?3BBIdJMMY+0uPXB6vU9ZATgTb511e7K3FD0F8rHCuPeoE9DUa1I9HfraoKlS?=
 =?us-ascii?Q?hg/YnWjnRYhyIcHkfsm26SUVxlnRV/XzMoma8IryU68qFrW2iM5TNxfHiJxK?=
 =?us-ascii?Q?9nfiFB0ZMLeGf+pcDPiIpL9MNDCvo8SsMZ4kwwZkl3dxvJNNypYWSRAsHq/D?=
 =?us-ascii?Q?Y/N8QL/GBtUjdECEEpjqa/lWqdpmQReTMNNeZJ1yEFOEyRhpgCABA0u/THQk?=
 =?us-ascii?Q?+tHNz5wwXvfQvPaVAhsJmM1oazpfNvrug6B6jsEPT2n37edf+95mlq7SYXie?=
 =?us-ascii?Q?IAzHKrGKHrpvuZ6q1siuFD92sQ1X3Vy5PhgCSg0dfx50z2bIBA1l39UgX+GC?=
 =?us-ascii?Q?8XY/tw7ofQBYA6ocsok2V4wJx+xV/tuDeccJgYAeWf61h/g8X5m+OuewDSAi?=
 =?us-ascii?Q?SyyUnperqHa7rAq6CLHlBMgE9wysLUy1YYHoIWzjIEyELqjIGlo5k0R6Y01V?=
 =?us-ascii?Q?IlpoZkhrqluATWd6Dz+hCJs+x0IesTdpkWX/qaoUFcWjorkKU3TEGtKeE8uY?=
 =?us-ascii?Q?vbQ30KfLw2uCu0z3xMHb0vnsTxE/FWrzwz0HrujOcez8QxSgjKOvfpWeo+lW?=
 =?us-ascii?Q?0TBcwQAFxzPmfSLJKInO8RlRLX8cwsTjooxNWRGAJl1Dy1I8f5eHp7lcK9Mo?=
 =?us-ascii?Q?cwqSbaQM6ARpmV9/5rPAJ6QDXGUtPl7wd/xyGb2c/aiYwWxITPWYIVYA8ck8?=
 =?us-ascii?Q?vFwyyg/UMA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ie9zjD9v5UYqkPEjDx5WZB59v8JWFe8b3BLkPrwH1OtxKskpgBi9w+YOZ64c+RbT0Rzg1bOTwPZoufLoiuqI7qZl1kH5hrg2Z15NdcreQvz8BypsmnzyxaFQgUbOU/Zqsl7Q3eEXlmyGNjjq9fiRrDj61LRx27wQ+oCy86VeVSRIvTN0gnwiFr9jI/tR17Lj+y2mqxKsmgmJdk9EMDjvuwJgBMCFruItDEXGISP3dOXgTqY4F+2Lh3anwFZE9BharrxbatP9PFDezNas3W+7H8sc4wZ6cm8aUNIZdR/e0rLow85qFuhbwwoq/GBFb1mjZrrNviLp2z5aK1r9jD67cQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf55d34a-bae4-42cf-3597-08defe6983df
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 03:17:07.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N0xvGSSNusz7a+Odrm7WlcIoRDApKrPjS7y8voK7shwApB3tOzs9OjXcUg+4pTuVghNu+2IcgYgbTeUy8ZVjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF12B0A4A9B
X-OriginatorOrg: intel.com

On Fri, Aug 14, 2026 at 03:45:09PM -0700, Sean Christopherson wrote:
> Explicitly track the root level for TDX VMs instead of trying to infer the
> depth of the paging tree based on an individual vCPU's CPUID information.
> Applying KVM's existing logic to select the root level to TDX is flawed as
> nothing *requires* userspace to fill in the correct guest.MAXPHYADDR for a
> vCPU's CPUID.  Guessing at the correct root level is also ridiculous given
> that userspace has already told KVM the root level during TD initialization.
> 
> Relying on userspace to set the expected/correct CPUID lets a misbehaving
> userspace trip the KVM_BUG_ON() in tdx_load_mmu_pgd() by configuring guest
> CPUID to use an "incorrect" guest.MAXPHYADDR.
> 
> Keep gfn_direct_bits even though it can be trivially derived from
> mirror_root_level as saving a whole eight bytes per VM is meaningless, and
> the value is queried fairly often and in hot paths.
> 
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Fixes: 20d913729c11 ("KVM: x86/mmu: Taking guest pa into consideration when calculate tdp level")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Compile-tested only, and found by inspection, i.e. I haven't proven that this
> works, or that there's actually a bug.  But I'm pretty sure there's a bug.
I have verified this issue via a modified KVM selftest, where I set
init_vm->cpuid and vcpu->cpuid to have different maxpa values.

The warning can be successfully triggered:
...
[15466.362189] WARNING: arch/x86/kvm/vmx/tdx.c:1629 at tdx_load_mmu_pgd+0x6b/0xcf [kvm_intel], CPU#109: tdx_vm_test/42260
...

So, Tested-by: Yan Zhao <yan.y.zhao@intel.com> 

>  static inline int kvm_mmu_get_tdp_level(struct kvm_vcpu *vcpu)
>  {
> -	int maxpa;
> -
> -	if (vcpu->kvm->arch.vm_type == KVM_X86_TDX_VM)
> -		maxpa = cpuid_query_maxguestphyaddr(vcpu);
> -	else
> -		maxpa = cpuid_maxphyaddr(vcpu);
> -
>  	/* tdp_root_level is architecture forced level, use it if nonzero */
>  	if (tdp_root_level)
>  		return tdp_root_level;
>  
> +	/*
> +	 * If the VM has mirror roots, then the root level is fixed as the gfn
> +	 * used to select between the normal and mirror root must be covered.
> +	 */
> +	if (vcpu->kvm->arch.mirror_root_level)
> +		return vcpu->kvm->arch.mirror_root_level;
Also comment TDX module should have ensured
kvm->arch.mirror_root_level <= max_tdp_level?

>  	/* Use 5-level TDP if and only if it's useful/necessary. */
> -	if (max_tdp_level == 5 && maxpa <= 48)
> +	if (max_tdp_level == 5 && cpuid_maxphyaddr(vcpu) <= 48)
>  		return 4;
>
>  	return max_tdp_level;

