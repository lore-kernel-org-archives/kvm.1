Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01242C3768;
	Mon, 14 Sep 2026 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376623; cv=fail; b=UU6z2H6+XaPu6fax9Ov12Vzqat04ShFBY8ns0wndZ1wxb2RcGUl4MeFJwBqMU3MxF2+zPXO16PFM0BrJqJMYB5ytZrNOkKhugP0RzIUspVaOKA/B8ZDO3kxE2D3R5ix7uWQrdR4uYN2qUyoSlt8xpmbQWty13/mQ5fCGc9Y48RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376623; c=relaxed/simple;
	bh=LCpJWzwIXcwj+6Mp7iH44SI5nCB8I4E41ZdFZtH7sns=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hjrjULsumQWIJpftmFtpEk4YPHn+xyJLrfJx3xxa/arPexPEQfVLQILozrX8lE+unwCkXCXT+aDR067xiTuS5Qg8QT+Dv+/BHvRYaIvJDSowtDX32RIwTE9WVFNb5lulHv/SsouRgWWo5Q2nqXs2ZN9HcPmicZLAJkzt7ErbIKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H58cPmGE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H58cPmGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789376621; x=1820912621;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=LCpJWzwIXcwj+6Mp7iH44SI5nCB8I4E41ZdFZtH7sns=;
  b=H58cPmGE9L77ESz60/Lpw2jkxEjzSxxpAj4XApUrw/V0ovVwQdZvRRMj
   US4Z09aUcELGblHwjrZ/l0cEmHGeRCC3F0nmrPyoCRu8HwGJBK/O9djoq
   1w2g1Gh8g/hdm746yMjOQg5QE18E8irJEB4g5E+JNHfBi8g2duK8VkXVD
   YCFLec5tUtvkdC0sJ+MPtKCTVOX5HgJqd+JDCmoa4DKuGKVEAS5PtMBr6
   Gdlh747mNshzb2pXAjrarnoMA3njo6UJEEdZbTyn+1Zg+T9Qix+1QEtGe
   8LppG3vVzVh9PMSalIVHoUnoVwn/cxTBX4Yd6W7BjDk4Rwmd6He1XLx3g
   g==;
X-CSE-ConnectionGUID: kswwqvNQSPKdB1HQ5krlwg==
X-CSE-MsgGUID: RRlFmtuNQzaE/aYMdIvBIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89854697"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="89854697"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 02:03:40 -0700
X-CSE-ConnectionGUID: fKErjVvwRKqKw/9Nv1evnw==
X-CSE-MsgGUID: w7OrNFwZT+m0h2lDuFFXcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="270788037"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 02:03:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:03:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 02:03:38 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:03:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtnhlGkzVQBIO+ezbfzu+Ld/RMmeAZlWuDyWxVn+8hkWp/JPE7+bcEvvnIOiibacx4OQDU5WjW/ry55B4J8WEjZ3B0IlzSnNdS7BU6a5WMtkn1tn+l1yB//sdEDSWJfnryYvOZy3PeVVLuAgWbNVATiuOxyVhDClw4G+SKxkehEhrD8/jm0l8ViF+SR/3AA6JWjGR3OlGGKCNB0PrB0fPk84TdKqt2YeH4d69SI4CTzEbArB52bCfL7wLVcT8ViCyM2XJ9cUOknep8g/eSzEVyUqSNoPGjvAcevBP0J7/AGSUspGIBcEc0THFe3bpFvhpXCzdjuNbHHvQ7rdKfHoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW/mpLmzLD/q7LCuVcRnxOKfyWIQASMNRm2J+95BJ0E=;
 b=CLFjHdiaAe9nACL2yHENtQNHbXWMSQ5lZ9HwtSwzOGpegbmt6HTbGwB+DLeIrulpLZKK3n0HPhqKxy7X7es0+sXYK2qNkf/awZKtL1OwphZf6LyA6Q8mtX2Unr7TQYPW9/WW4DQ6BoycQVKJyplQ4sg4yo/WJn9Dn6ItqbE6QuSBYNkrk7pznK4BQhEw0OLMGYVEgH0IsMHZ1YjIJmdrp7zi5QodA7cgMqd75/vLGu6p8dJRc+Z0HJJbgsOShDP2/TmSuCZcHByakze+azT1cnQAUrRysiWSPFvuQ9kVsleoa11QJp7uxdgLF0OyHd9jxG3OdsEbJKzIDZlfYz3psw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:03:27 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:03:27 +0000
Date: Mon, 14 Sep 2026 17:02:56 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 1/3] KVM: x86/mmu: Use KVM's max TDP level to
 determine need for 32-bit TDP root
Message-ID: <aqe4QCxIhcoBL+po@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260902230932.2760127-1-seanjc@google.com>
 <20260902230932.2760127-2-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902230932.2760127-2-seanjc@google.com>
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|CH0PR11MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd41492-ea31-4ac5-f56c-08df123f09d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HuZBGrDy/E7Vke3iPkkp8Lwlc88CxojPbTMIMOgFTcIbKpmCi9CMXRsmB3BT0CtiqbCEpoQs2uAr0IlKV9lJFVLaHx+zVH2YulLHUSpiWICbvyGA7ZrDfELtHoyVOF9aTDAj/jRxHlALFhdkyWhdFmUdQH9DZ+18keY2iwX1aYKwKHWPqObXt1JJkUA8SXAf8jEgFpTay6JiAhJ4KezuOd9BFblqk4Vb85QPsPuuFQ9HT5Zc0jjb4sFvFivRSCSbFEmJ9dBuAB1a1mTcteHhhbdkpxbVeAb+u9XuqD34AkIO+OQqDAZvYgf8SdCrfcj1hIw2YKtBjBgQWSVjKdJtSrRTAEcDAGFpk27NUxzMBLwqEdY+eflZthP44rFnI/ZRwp63YNwn5NrEexbrI6twP7gsVPif8kK3n8ZqqudfXr22UaOaNgzYOB0heJySAee/0Wo/XjsD2H5xEgYVqW7B1XXpxfiFe2/C8titFgHuoE1WypDMs4dAL7eQObzEtaUU0JlUT7iX8hT++C0h/UyNR2bp9CTeWMQJyCw3fdylyTdU66Mk/kTifFDiAPVueqh++Ta/XksM4dVI/5UWQOc/EZ8xpvi+vpS93dGpKxYfP/8a7siW844tLoNj7Z/lQI707UqeKugZbhz+Hf+uRSOmSiuEDLlYZdBmUejxkEGEA1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kZ1LTv9b0Y/N5OxrT+Xjcvt1fPBZkLV2zUIfe3PRFUyYfQse3LGvMYroe3Cj?=
 =?us-ascii?Q?wox0buQN7Ooc5YDp3CEOPESSRWdsTpx0scP7Xz4aCw9YYBCIgAg0ZuUW3Anz?=
 =?us-ascii?Q?UTkJsDwXTSrJeCJy3QW/Q61oH77yvReUUgsV0iPc1EfXsfgawF9fIe1gTUVS?=
 =?us-ascii?Q?CC8N/jcYTPW9diFvgzdZQ2FiKW5bwTyM0Pa3B/u46B2qemZmaLCyvp2btSby?=
 =?us-ascii?Q?cMGz9NqaiQb23X1G6c/JrzirEwM6ixbViI+t3biNSVVWupuGxm+yAxeVbQJw?=
 =?us-ascii?Q?nqdQUPTL2UrSzWIgHD7Xf2qA3nPLhZgUMOYgoTXgpripdkCa1VPOtPgIjC4S?=
 =?us-ascii?Q?dtgzgdcYUdsNsaZcNTSXdjedyQb/gxvIgOjBTGRpr2LiXzbXx2LcC7+xPsoG?=
 =?us-ascii?Q?Nt8yJsI9Jy0PoEkaNd/N6e+kXP+LkmSQpf1L03pMZL+eneqMNi4nAMauBPej?=
 =?us-ascii?Q?FhLlQEWl8Jg/eWsfMYQuSUZrQuND6KUb7U5ocJplAyVZGBD3WMvFDm4yDCsU?=
 =?us-ascii?Q?eqU34rfYeZ1ml3AebV8xrXveehV0wkWveCUIgk5biaVbmit4TBG+38m3YWbm?=
 =?us-ascii?Q?ZvXRx63QGUyeGtGZap0kuDG9j59n8i9e6x80/7/GEBeWUP0JjSNigUvCGROu?=
 =?us-ascii?Q?hXqpGFmxYmh61UTNWaoGzHLtaxKMC03jUTrmCNmpT0H7dGvYkg7etBC6XTJP?=
 =?us-ascii?Q?9D6n9ctnCcwQLPirBWP6LwteV58jTxZVFFaGLsb/VaUyDu0Pi2re/kPiEf4I?=
 =?us-ascii?Q?zT+3WexJmt5aLr4bkOqQUUAB6Dp/1aL8A6eKbD22V0MjblU8xJ1uc0TgpXsM?=
 =?us-ascii?Q?vot/d7nof9qj4CuLY9HCaEINZV9/6tv0QC+09k0pHFKOI31aYFylvE8XIeqg?=
 =?us-ascii?Q?UpdXNbaHpv0f9XPiPhUoHf/17voVwaN+ot0p8D3NuLcm9ZgaYSrbK5makxmq?=
 =?us-ascii?Q?diGG3rLNstiC9iq7n6Oj6z6Wvcjti1SwZtgudM6T9Pkp3/ca/wKRm/6FUt+U?=
 =?us-ascii?Q?Qg2Z84Z4q9ZK8uJITUtvxlmOP9kcD5iXwyUGKwe7rJMW+iIVKduLQQA22rQI?=
 =?us-ascii?Q?SoqkGX/7u2CTKD3qrm5g6jxBlbZoe8W5U5eJhlz0YRUAEuLOKCqsEOBuTrR5?=
 =?us-ascii?Q?foiTkXjiDZymDSsJ44swAgbRrY01dT4Ppair0gjdRvPO12t/8p29nVLVmVLk?=
 =?us-ascii?Q?uXLEKaJOM4yHbI9lSJ0NeOSABwKXnAhhNBigBGlJcLKjFXSLqjtIcfkyRs+S?=
 =?us-ascii?Q?2CvFOPX9AwaozPuPS4KiIKAv4Y2gE5IDxDrnviQTArCd+r1LV/U20EIezghf?=
 =?us-ascii?Q?9BTFj/jdnTGy3AsP3nP8r4SBcaz2K3Jz2fOEIfuVWcRmuLWh8iPRZug9sdMf?=
 =?us-ascii?Q?Q0KAPaqYpTSxjUSuhltAmd7seDRW47XX4RYAbVF8XZpC1m/w8XxFczmvovig?=
 =?us-ascii?Q?ZMErGSK8iDjer+9FFy4JJWETrM65Ms7aZ2W5GRKRuPSwUPhz7kt6zI3T8cuL?=
 =?us-ascii?Q?tMizZ1RhU1TElxUwSBngb/8q1jxi68CMGQS3Ba58ojTWID/6o40LMlTf15xY?=
 =?us-ascii?Q?AUpD3YjlpvixS+RvaT+YZV+iH2m3s/eyeSDvlHNSLhdgF59xosX6IkSBxB4n?=
 =?us-ascii?Q?izQv5BTmLC6JyMuC9zPK93Xs9Z5nYPniHpoaJCVFSZrXAkAEr+gLHXYsYYuH?=
 =?us-ascii?Q?D0duLrKCJPzaNv69wkx8hYdEftVdSRF2TRa9eePENvW3Pxt3UgFu3ED6si6Y?=
 =?us-ascii?Q?bhmnTHxnEA=3D=3D?=
X-Exchange-RoutingPolicyChecked: QFb81/E6b8BcdP/KAiJMAA42ETr8ubWMsvEBQwLVlGCCn3b5M/PEswhf1T6mTgajoVqogAOeYvMq1GOgHX1VBYi/XUvyl5Y76+APXlGlx4V477EegPR+j8bLYTKB619Q7tsnLpbXWtwMw7xsN3qpyifo/MGAkxEYmR3byoXnyElif0c0DgCOPqOcQ7mMkb8dwCUoLOk4haqgS4njGdEThwR8AJdpFvs9b6zgEH58s276M7Qcx6qTFnEkDPX7JNsYka6P1a7SnVeXOAthXG61zvsoADgn41wfVKMpqzu92q87Y1CiJBZt9Q4M92a9rDJ1lQApkXo62h6cJXLIHddWfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd41492-ea31-4ac5-f56c-08df123f09d3
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:03:26.8634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNYonPzJvLhbcLw9x2JtFbCC5dixfcS01yyckh1AU9HoE1NPFWcQZ1wLrx2umCv4//HpAYdME/N3fWJX0OEutw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 04:09:30PM -0700, Sean Christopherson wrote:
> When checking to see if KVM needs to allocate a TDP PAE root that's 32-bit
> addressable, query KVM's overall max TDP level, not the vCPU-specific TDP
> level, as the logic is specific to using NPT on 32-bit hosts.  Querying the
> vCPU's alleged TDP level is flawed and confusing, as KVM selects between
> 4-level vs. 5-level based on the guest's MAXPHYADDR, and MAXPHYADDR isn't
> yet configured (via CPUID) when the vCPU is being created.
> 
> I.e. as is, it would *appear* that KVM is violating its own rules with
> respect to changing guest CPUID (see kvm_mmu_after_set_cpuid()).  In
> practice, the flaw is benign as the goal is purely to see if KVM needs to
> use PAE-paging; whether KVM will use 4-level vs. 5-level is irrelevant.
> 
> More importantly, avoiding kvm_mmu_get_tdp_level() during vCPU creation
> will allow hardening KVM's handling of S-EPT mirror root level.
> 
> For all intents and purposes, no functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 064ecc33b926..c9a684151420 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6834,7 +6834,7 @@ static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, struct k
>  	 * other exception is for shadowing L1's 32-bit or PAE NPT on 64-bit
>  	 * KVM; that horror is handled on-demand by mmu_alloc_special_roots().
>  	 */
> -	if (tdp_enabled && kvm_mmu_get_tdp_level(vcpu) > PT32E_ROOT_LEVEL)
> +	if (tdp_enabled && kvm_mmu_get_max_tdp_level() > PT32E_ROOT_LEVEL)
>  		return 0;
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>

On a separate note, though it shouldn't be a real issue, is the below change
necessary?

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index bb68a021cfaf..abbba26dbdc6 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1810,7 +1810,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
                        phys_as = entry->eax & 0xff;
                        g_phys_as = phys_as;
                        if (kvm_mmu_get_max_tdp_level() < 5)
-                               g_phys_as = min(g_phys_as, 48U);
+                               g_phys_as = min(g_phys_as, kvm_mmu_get_max_tdp_level() == 3 ? 32U : 48U);
                }

                entry->eax = phys_as | (virt_as << 8) | (g_phys_as << 16);



>  	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_DMA32);
> -- 
> 2.55.0.970.g62bdec98f9-goog
> 
