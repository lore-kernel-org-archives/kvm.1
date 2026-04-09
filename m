Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0B2F49FD;
	Thu,  9 Apr 2026 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775713909; cv=fail; b=PGlymQbvQknm5RU9APpFph5u5Tmo/dTOnHkTIZZL9xac91819hNNx+QPGWcdWq7RAR89sg1yPuXAf2p+LOnR8Xiw6yOgrFTBus1hYUa7HGJ58lQPExiRrMKACNlAC9y/SUbosY9WjmrF/Nkh2U70GzfAVA8Zcw5UHLM2PN0eJMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775713909; c=relaxed/simple;
	bh=vlaN6XS4DHCM7zGsS3enNBywR051FloIWdLUr9fKlzA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sFcZqROfZOVCmqkqHMtRfciiHMkzPtZ9H3SX43CHL5mK0JY2Fr1sa0BF84RsrUr9Xynmi/7Zabp/sgCGWcecdrqmqNvZoKnpF9+NGQ6rGoOlN2PTEvJIob5hz3VdrkWZmsD6B0QRviWvSXtRURKBhaTCITUEsgnUnMKePSluRcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaRcQ8La; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaRcQ8La"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775713907; x=1807249907;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=vlaN6XS4DHCM7zGsS3enNBywR051FloIWdLUr9fKlzA=;
  b=FaRcQ8Lau0GlqkTx9nXWPMUbUE8n/ndwzbyKE/Vx7cG2AG1Hz45zj/Z3
   N2vhu3sj7HMGLYM0j/Pj5MpRnvpho9O6gcltFVJuaadQbz0tlgFzljV2z
   QhqQzzaEE1PmJRb651ale3+OTMGSbZhbcLN28LrBelyDSQdO4IqTDKYfy
   a2GL5zdAz3QZB+x+TJrrO/QJz1w1z70bs8tpa83k8YSdHZlsKGOwsSxYx
   GUyUjwWA6/WBWd8rm/L1PI7NNvP0zSnwUuMHX+PkaT8OgMjC94VSsZkyB
   YZ3B6Nn9BixDaKFBf83bxlsmP/22GFgtpIiCdN4zfMyin2UnMr8krOvdu
   Q==;
X-CSE-ConnectionGUID: rVt+XYBZT4C1gmhjsRbauA==
X-CSE-MsgGUID: Aw9zDoDwTpCOb8CQobYlCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76831712"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76831712"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 22:51:47 -0700
X-CSE-ConnectionGUID: Kc/I0M/pQMq+L8NOaV1TZA==
X-CSE-MsgGUID: EBJzAFgOSBGam9YN8tvQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="228558427"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 22:51:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 22:51:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 22:51:45 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 22:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0gQzBytzTrRQ07acF5AQtc/39lFUU/edklmqi3/4d7RTB+j1uAR503WZtnw0ep7IKkRJrFUG0UsB2xT5e51IQkw05uxyeLjdLuAr9QFD6wzYcLyjOvy12Sr0sejMsJmUNQacJAlh2iypYDu28LROcmhxSDpP9QvDLeWOv/RHh0ASZNP9RcnP2q1+rgINRSclm3KSOFY2I+kAjc6ecQ+4X/og8bmMeAwE5/Zjs8Hy6kBlOj4zk3GEG/1VPcd9kZoFaKoX3hzuRTQcfzsSqi7pANNbn61rm7UMsUoSZCybt1hygAa8RK+WsXA7b6hBMpd+/Hg1vY8AttS97d8+cUj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aUm8Fs2Nw8oI8FzxvOdFQg2kKkfDezIWZ5bZM+bRMI=;
 b=HVv0OSdnYJxdyUyItjWEPZ4SR/wtLQ31O7cvI9eWhpb3t+0+jqIL74+1sWTkGon4vri49z69qaM9Z6Uj0lPPMfU+5BEABLyEGxc+Pqbny6LzVXT53aMyUEThrUns34Jz+vgR1jRu+ExSi8YSkEuj5viacCfya7B2s7bGY6oNAjekTzMWfxSGdTb59Mz50Ct0FBlkFnNN8rRGfezByBP2slSRrOsRcEnN2TPmTrumotfHlxvcZE961yqjxga6/PA2dVn9gcDYW6LFpzmmohKMjIh2JzZkTF4nxPKCW8mMQXfFNczcYCkflgBBctC4BmA0+jpmy9tmAVZEIKCrREj2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SN7PR11MB8112.namprd11.prod.outlook.com (2603:10b6:806:2ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 05:51:42 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%3]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 05:51:42 +0000
Date: Thu, 9 Apr 2026 13:12:02 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jethro Beekman <jethro@fortanix.com>,
	Alexander Potapenko <glider@google.com>, Carlos =?iso-8859-1?Q?L=F3pez?=
	<clopez@suse.de>
Subject: Re: [PATCH 12/21] KVM: SEV: WARN on unhandled VM type when
 initializing VM
Message-ID: <adc1IrD8uqWdaOKv@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260310234829.2608037-1-seanjc@google.com>
 <20260310234829.2608037-13-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310234829.2608037-13-seanjc@google.com>
X-ClientProxiedBy: KL1PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::15) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SN7PR11MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e80b563-69d9-410c-814d-08de95fc133e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: GLd4jPKb7EBUlMX1iLl2Ky1SqJyu/LLwnIsJvHwddDJcasnXRSCTtd9+9+kQx/9vogMIh1zEFqnVF6teZUAf/hMl2OpmvF6Qm3YaZGH4eieoV0RCDqhOvO46c/jdBVy7DDDev9hKc/MNJ02cnPWkT20lZQ/oKecQs/ykaKzalFyDEss5NbzvVQ5ubaz6vpkzLf5QsGleQSG/Cck4IatVdEXt/Kos32OFUr1GFJ5O0QChDAgKdjCuJmA/n48RqUi0uANs7X7uAm0UKvKEZYc1VCIZrhKydes6ojQBubEK46pauJDkRZZE3dly5Mhdu2HAVT6lP2ubp5GsrHW2REKpllMssA3bG/q7Nk8EHR3V8+U4h53ZQV3vZLWlPTAJz+YQ/+FjamfpphyCbaeD0921a22yCRPrKkgcwgUYQUqTJqlUeH4KOpGWDUj4xfxhVaRL2oJo/uEzJRmt9P4D2NHFz+0bntHKNZ+wnzb5FZTniSkBc9J66QB9Jv2jA6P+DgYVntTjHrHcyVzeHN8ze7tdvdXzvlUd7Q0UE8tLTQLL6fA6mIq2A1+VsWH2k3uOL6sZTJf5wwRa+kE701vfrgDzW7z/UheDz+3dws7MbUZMZBCz+GH73xH4IjzOE53yvOhAGHKD3JLH44DCINHaD955MWmg3R9NRgT0R7H6jw/wpEZTmIgwu+XN75f7ffMq5+iD+miAUiTXcHFvVlGJeKWp9tanvF4WzRskkLOlkNmryg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2h7kQFSB3RkrKDXBPCkwENjoziXtbwhe46upW0tJEzn9hoKncJ5OH3ASnkO?=
 =?us-ascii?Q?Mia46uOfw1WMVfA5kR1mLrAi5/6AqtW+2//BNxvS0/RGenX396SJ4//7JqXG?=
 =?us-ascii?Q?3hJDQs+iiXxeTJxA9pSRLh2lPXAV1UH3m2vNsiT2S2JUcQgXp/YZRtL6aMsl?=
 =?us-ascii?Q?Id8O8hHfSucfTsky68iB9fnbogLOYB45W4J70jP/dYt6Z3KvXYLhfo2N1c6c?=
 =?us-ascii?Q?dl6mhwGme1GYRKLt6ThUYxrjMAr1Ncx+i0P6QtWH1RUc3vfXCPl2MMVNxZ7f?=
 =?us-ascii?Q?eQssU+v+VtrGJDpKLtoh+48wytM4rP75DX6Apdgpjn8ftk6KtSkapdDGmhaG?=
 =?us-ascii?Q?PdPUdOhhw/tzQmzsWELBvh2l9ARtgwcHXVedGUOU168rouCZOdtgFelkEuHP?=
 =?us-ascii?Q?JISsxtSUUMHwj0ldjC+j1VNdetmXmvZjmVSmAqrQIDTWzqkJc8L5r3NFp5EW?=
 =?us-ascii?Q?J4HsAeMDno3IZbuyHtUdU99F/hGUVffwiIf5f0Q+FfWCWElOzk07Rno1pFQM?=
 =?us-ascii?Q?nyh/Kjrrg0VqRxgCpsn5zItn/3rO2oACb3/Ph5jx32cTB2MK510XUUi7W+OA?=
 =?us-ascii?Q?hmxqjhKh5K0dyogmBQLzgfK5QqcLsBswrz8aVYCyNBUEnwvXk48wlIAbLGK5?=
 =?us-ascii?Q?kXA7ZkbaYlwU9LAh6REEF5vqtmshRR2axsZWlKVHSw8JuobPhl64R88wNdNp?=
 =?us-ascii?Q?mdbBfEhgiEItHlyE4SkyJ0CeXgQXxQ1ZoakB9ImSYbjRyggvoPY98Vy+QuaK?=
 =?us-ascii?Q?M3Nf8W7yUT7ilyix4UCn28LjodoidiXPx75PHFOddE59DGxuQ70LGxXxCBWz?=
 =?us-ascii?Q?8xxI6VgTK9Z9n9AnTzYZMqi/N+IaCFMmFaecYgHEiybIk2GHz5DTzi3r6IQD?=
 =?us-ascii?Q?pKQRnPspL9CiIasI1C/m84Oz44OVNIB+fh1Z2CHEy/DHsUqQKglwiA0Zhq/R?=
 =?us-ascii?Q?cyTB96yHzjbvCZ3/MghTY4ud4OWkB2ixEMUNG0r6zAmjBEsSxOXvnHtGoVZV?=
 =?us-ascii?Q?9nT0ezF73HNaF7qAiF1lRoToe51rEaLUzUl60P9HUBSogEy5+JuLYA5ad9NN?=
 =?us-ascii?Q?GCsVTfIPz9Wu8M5j745kqkWrIU7Kk9UwokVps49hzLNDNcSmk3uCDdugKcFQ?=
 =?us-ascii?Q?/SEQ3QSjR247MQwRlvjWL+EXvN1yZub129tsYZk2f90NOzxQrbaa9Q+F01tF?=
 =?us-ascii?Q?Qg9xgZsaST99oQnbCwY/0iq+CL1ltcHtHXt89RqYgsiXXddcq3MJQHbxdtpG?=
 =?us-ascii?Q?QZmKOMPixHnOLNSEh80nqeM2mu/Bl1/8Z06hmeUplxlEP2kwkCMdzxIpwZE6?=
 =?us-ascii?Q?xuJTQPsPbH7uVy7xYGi0WfrH/ghxdcjjwK+VEIAKMVyHDk5Zca1hohfS6gVD?=
 =?us-ascii?Q?hdBPn4EX51VG/CafzacEvaDCdCatjhdiUdUKFc8ioMyidvkw8STKFJuhyNG+?=
 =?us-ascii?Q?kB3EW2PmxwxpBhWvNq3Ycaf2IVwdLYL3xOEk0BbK1NEs2Jmtt4pxhL4UTtxY?=
 =?us-ascii?Q?icrJNj4y5bbXkQnxEY/M8ie+LOy0bxg397vUIJ7mcG9bGjsnk6QBrjb4VGD7?=
 =?us-ascii?Q?VLfiyHQptOOsZKLphWYJl9MlZgV6YLKT/eEGFtrAyihlQ0m+1Q26IowsqSTY?=
 =?us-ascii?Q?hlfCvHMzQ9SNB44OEAcsLvxGKL4UVLW2lbMWFSlDTgsg+7USDPBibVtR4U0U?=
 =?us-ascii?Q?iozdHqF7iBsd5U32hGeKR4kP+KcSWEw6A1ZfxbfgaANw9yzvxhBwn4FjlxUo?=
 =?us-ascii?Q?/AV+Svr4Cw=3D=3D?=
X-Exchange-RoutingPolicyChecked: oXeQWYZKNhJaCrd/tn8fCcrq71u/TLvz1TAy+LJ4wC+zw83z+1bMv82wcWHpbJ/QVzBsyLHJ2AGWlvVImfamdvW4K56deUlOfCDNrhzEHzlxz6AJ+m9haDm81lC5V8lNJM2CEC6dmmJL9DB0DIm8LOd8Y7vdEiZ9UgOxQ89W5ouTqzUIO9N+rxobh9EwtXtMGTp8PCbcXePOYp4M0EvgLjOCp9rp+ak1UoySLELfZZGNHCwsElOoLn6UR6j0/5QapgYVaIEEaw1q505DJgIP2Vi3MV1OfchlBnKp7xaSh78h3jbKbUh8Y+u0W6fnftLpa+/qN6C8P4SLr6Jz2om/Xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e80b563-69d9-410c-814d-08de95fc133e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 05:51:42.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ig0U2f1WA/gCvNsJHbxOecI7UlU94XhXKTXxdCGprfscfmQCPaKslAsbwNp4erBTyASrydpSfLvJ2ecEsVU9aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8112
X-OriginatorOrg: intel.com

On Tue, Mar 10, 2026 at 04:48:20PM -0700, Sean Christopherson wrote:
> WARN if KVM encounters an unhandled VM type when setting up flags for SEV+
> VMs, e.g. to guard against adding a new flavor of SEV without adding proper
> recognition in sev_vm_init().
> 
> Practically speaking, no functional change intended (the new "default" case
> should be unreachable).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/sev.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index e5dae76d2986..9a907bc057d0 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2930,17 +2930,24 @@ static int snp_decommission_context(struct kvm *kvm)
>  
>  void sev_vm_init(struct kvm *kvm)
>  {
> -	int type = kvm->arch.vm_type;
> -
> -	if (type == KVM_X86_DEFAULT_VM || type == KVM_X86_SW_PROTECTED_VM)
> -		return;
> -
> -	kvm->arch.has_protected_state = (type == KVM_X86_SEV_ES_VM ||
> -					 type == KVM_X86_SNP_VM);
> -	to_kvm_sev_info(kvm)->need_init = true;
> -
> -	kvm->arch.has_private_mem = (type == KVM_X86_SNP_VM);
> -	kvm->arch.pre_fault_allowed = !kvm->arch.has_private_mem;
> +	switch (kvm->arch.vm_type) {
> +	case KVM_X86_DEFAULT_VM:
> +	case KVM_X86_SW_PROTECTED_VM:
> +		break;
> +	case KVM_X86_SNP_VM:
> +		kvm->arch.has_private_mem = true;
> +		fallthrough;
> +	case KVM_X86_SEV_ES_VM:
> +		kvm->arch.has_protected_state = true;
> +		fallthrough;
> +	case KVM_X86_SEV_VM:
> +		kvm->arch.pre_fault_allowed = !kvm->arch.has_private_mem;
> +		to_kvm_sev_info(kvm)->need_init = true;
> +		break;
> +	default:
> +		WARN_ONCE(1, "Unsupported VM type %lu", kvm->arch.vm_type);
After pulling the latest kvm-x86/next, I encountered this compilation warning:
"arch/x86/kvm/svm/sev.c:2954:30: error: format %lu expects argument of type long
unsigned int, but argument 2 has type int [-Werror=format=]",

So,

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 75d0c03d69bc..ca09c06d1e80 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2951,7 +2951,7 @@ void sev_vm_init(struct kvm *kvm)
                to_kvm_sev_info(kvm)->need_init = true;
                break;
        default:
-               WARN_ONCE(1, "Unsupported VM type %lu", kvm->arch.vm_type);
+               WARN_ONCE(1, "Unsupported VM type %u", kvm->arch.vm_type);
                break;
        }
 }


> +		break;
> +	}
>  }
>  
>  void sev_vm_destroy(struct kvm *kvm)
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
> 
