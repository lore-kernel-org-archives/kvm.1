Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BBF3CB54D;
	Mon, 12 Oct 2026 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834816; cv=fail; b=H843ChZ8wPZao/DQz8NoSjjrWqHqwV196YoAlx+gLPnVwJJmDndYmSSwqTL7rnyvgGhjaVgpxlis+rFiDipx+4RpfRGl/xy1lpTv+CqzlGJgYqo34DSLaDU26WvNNRzYYPKNgAfMqFnjQjCL/atr4t6gR7VxKKruxI++qCGArWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834816; c=relaxed/simple;
	bh=X6nOt7B1yuVbwUCGVoZjo+7Ke3u60SG0Lc0KzBUY328=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB1s48EUIoeGFZN26EdZTjGMgCxSfHlXgLUXru9CGXJhUyd3hzAUb0yuhvC/XrdTv8+kXP+r9ep9jYgpnOuwFJEJwmq0UL+S5zBgjpASUf5dBj5NB2iD28oayS+5trFCg1gOxlTYofgSwh7NntyOxq5Wn/tkNdr5ogMS0cPt+S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dU7J//dJ; arc=fail smtp.client-ip=52.101.56.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dU7J//dJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oizkKP8t9LdFu+ufzfgVN+08reB1lH3xE2ruJil8KcJOcy+9ZmLyxqVz8gyqMpkBGYLd8dzIYdfINJBKRjuhs6I2ykEuI6Aw0WFY3qrAZegpQarRy04QzJYiwNItp63cRwpW30h/hZRAvnle9LlqqiHytt5FY9L7BKfpQgNV+Ow6/kDoMHFf1rCREeSEKri2w1IJ4axglIVE1aOL84RvBsFyPSkAdoke8qoRTGaVljKf3q//ydCJ+OzKRcvqG43V1gKQ8ZHMqklR2n3rBDxY0LTsULJVooqcxB/pGzaj5NOeynM4YrAGPuMN0DjIWoqHtJI4zY0ItYpp7LiWaxkZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbY+dyiHHFfKM1ltFkJY2JAB2p2KGihqeRlczPJaU88=;
 b=OBTN3GlQQqgLofnjG+5oEgjqlGbgPFBqUcug8oRwCG4fARkQIwf6WGY7sFKu8pBxFcNR3NLC70yR+1dLWxgNqiniQ1QmdAuFhYMWFR3GYpCibzMES/1qWjKKwyAlOte1dKiBc1mqU9MBLMayQxuT3n4KM5fceixSY2BoQhvi/HWxDBlPgiaGPVXbwny+nhuDU5AJfNhqT5/xmrIsWceAXw0Ea61bcX11onfHNGTNVqI27IsqfjRzQrv7I/CwL87ad0MPCeh5TG5m9jM+qWVwEMMa8LH4YJIQd9a3Nv1PmWYRP/let1iRbP8rPIgrSRx4uOkiFhnOyDgtnlsmzj+PYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbY+dyiHHFfKM1ltFkJY2JAB2p2KGihqeRlczPJaU88=;
 b=dU7J//dJITpOOHFqf4Y5rT4Nv6OV3CmrPHTY4zRq9XLr3kFjlsfy2fh7lD3U0lSS8xpyetDDMY+cKFHi1jGIRIr/VkZGcyBGPJjO8AMoGIrGFgyXNoupTOnw0FnZhxg7Fep1a4Kd0FfhbInRAnt+ppi6nIxiFfAgbNcJhzkaZuc=
Received: from DS0PR17CA0013.namprd17.prod.outlook.com (2603:10b6:8:191::11)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 19:53:23 +0000
Received: from DM3PEPF000265AF.namprd02.prod.outlook.com
 (2603:10b6:8:191:cafe::47) by DS0PR17CA0013.outlook.office365.com
 (2603:10b6:8:191::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 12 Oct 2026 19:53:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265AF.mail.protection.outlook.com (10.167.23.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 19:53:23 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 14:53:17 -0500
Date: Mon, 12 Oct 2026 14:53:08 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Lisa Wang <wyihan@google.com>,
	"Ackerley Tng" <ackerleytng@google.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>, Erdem Aktas <erdemaktas@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ashish Kalra
	<ashish.kalra@amd.com>, "Tom Lendacky" <thomas.lendacky@amd.com>
Subject: Re: [PATCH v14 13/22] KVM: selftests: Support guest_memfd in-place
 conversion
Message-ID: <qyykjxnxek73ddhbdexwz7jabjso33hdqzpf4syhrbrlh4eo5q@f4hwiuluzvgi>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-13-15ad654a50db@google.com>
 <f7b3a63c-7a1d-445f-b062-4cea5343d266@intel.com>
 <asz8GKNO9aQANr5E@google.com>
 <as0FedYcvJvdOaq2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <as0FedYcvJvdOaq2@google.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265AF:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 143c0e7a-6cb3-4a8f-6c28-08df289a7937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	S20rnumm7kPPnfsMB5sycEscpaProbXCf6P/Mybn2bKt18VO22g3CT9UNlp3vn3vCdWtYzONm1l7glNEBkzUC9RjmmWG0AJHApjhZeQEECNZpC851BT/Q6LjUmnnX2aus/9ITXBrq3CQh4NkKem0p6HyLEzbR/7v+knBQ5cGEjA0KPaVC//ebmNdomIujJPV9Xu5vxoPVUIVYrT7lVmepE1DYG4QZjw1/DdBh6KSK+90+yLzpL1Gm3BfToKw2S2P1DEU07CF0w0sjrJCUQg7GTqXcLG6nvJMO5ZCymnlLdwFkcFw53LcfC3WRwzWRV9Ykt1GOjyJvO/eAq0wp/Z23hi7ENgn0vc7IJyLPawO8SbpP2XVjOuKYlsS2Dv83RQh/8CGUdH79LkAWN/0Dv/gEQ+NZh/8YMQmW6nEv2dBXx4BILs5rfUJa6Qk0FrSBoW88dpxK8NZ+u4cOl+3CZC1t+EaqW02bgw6X9b4zuyEIy/YnAj5OMC0NaUUK4mqAFKau4g9LUICDaSKEAwawtsZcqVX/j1EAjfhs9vDYXPJtMZgmWcME19cdVxaq3kwGjl4lZSOgFRXM9p7g5FPht9YJdVK6/uXplwee47QM4d4J86tvuuYFBA/KMc24qwyRZ+E41HPxLfkZCvbvl9ho2n8/mx1ibUADGRrxQR4Q+8XxM9vWruhhQEd4LemtJK+L+5LDCHEalTLdi1sh6ZAEsQFRA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9S5WcPgd0T7FXr0dIeyB6YmW6xOFJ3pXwNINXpgqtqF59EHmJbz+ydsq0F6elzluxTwpAFYfrWSkuUO2+ujJfsLDRuVuPm1UkjftOVVA8YnuprTpP07pWdIxle0GNHll2zTfP9NMr7GNW/4fbnQEidvQ1Pg0kwJQcIdVA6u06vV0Or5QC4PK7RRgSGe8lOHLrYEWgM4Ehw/jkkeAFipnStwkGqKPTUP7rmKTZCqDKIwT0AEgMBrXlnZbXjgpROU+zhfh/XrrRCYlCVTyMeFwTp8/3aPXDV0YgULwsgpfkD1M+KVAn5aXOxp6/BN1AqT5K2o1aYCy2s3SlWW7/gDcsixtIfzZEzrGAHH7fiXeteuU5DXRJ+eYEk8Fzh4Yzv6ZxexpkD8sjQA+9+4kYnR0FR50BeSKf5/kDSWJSfQ27CzJaxWvTBH7UuO9OcoDm2jS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 19:53:23.2841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 143c0e7a-6cb3-4a8f-6c28-08df289a7937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324

On Mon, Oct 12, 2026 at 09:06:17AM -0700, Sean Christopherson wrote:
> +Ashish, Tom and Mike, dropped a bunch of others that probably don't care about
> the CCP/PSP driver.
> 
> On Mon, Oct 12, 2026, Sean Christopherson wrote:
> > On Tue, Aug 18, 2026, Xiaoyao Li wrote:
> > > On 7/23/2026 7:13 AM, Lisa Wang wrote:
> > > > -	flags = 0;
> > > > -	if (is_guest_memfd_required(shape))
> > > > +	if (is_guest_memfd_required(shape)) {
> > > >   		flags |= KVM_MEM_GUEST_MEMFD;
> > > > +		if (kvm_has_gmem_attributes)
> > > > +			gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
> > > > +				      GUEST_MEMFD_FLAG_MMAP;
> > > > +	}
> > > > -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
> > > > +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags,
> > > > +		   -1, 0, gmem_flags);
> > > >   	for (i = 0; i < NR_MEM_REGIONS; i++)
> > > >   		vm->memslots[i] = 0;
> > > 
> > > IMO, this diff belongs to the gmem in-place series.
> > 
> > Yep, you're 100% right.  I pushed this to "coco" for now...
> > 
> > diff --git tools/testing/selftests/kvm/lib/kvm_util.c tools/testing/selftests/kvm/lib/kvm_util.c
> > index 3f559f207408..0c67d964a9aa 100644
> > --- tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -494,6 +494,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
> >         u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
> >                                                  nr_extra_pages);
> >         struct userspace_mem_region *slot0;
> > +       u64 gmem_flags = 0;
> >         struct kvm_vm *vm;
> >         int i, flags;
> >  
> > @@ -509,10 +510,20 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
> >          * for CoCo VMs that require GUEST_MEMFD backed private memory.
> >          */
> >         flags = 0;
> > -       if (is_guest_memfd_required(shape))
> > +       if (is_guest_memfd_required(shape)) {
> >                 flags |= KVM_MEM_GUEST_MEMFD;
> >  
> > -       vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
> > +               /*
> > +                * Allow mmap() and initialize the gmem instance as SHARED if
> > +                * in-place conversions are supported, so that the memory can
> > +                * be populated/initialized like any other memory region.
> > +                */
> > +               if (kvm_has_gmem_attributes)
> > +                       gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
> > +                                     GUEST_MEMFD_FLAG_MMAP;
> > +       }
> > +
> > +       vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
> >         for (i = 0; i < NR_MEM_REGIONS; i++)
> >                 vm->memslots[i] = 0;
> > 
> > but the entire in-place conversion series may need to be dropped because there's
> > a potential deadlock, and I don't see an obviously non-awful way to fix it.
> 
> The underlying problem is that drivers/crypto/ccp/sev-dev.c does memory allocations
> and copy_{to,from}_user() while holding sev_cmd_mutex in a variety of locations.
> 
> I genuinely think the right fix is to not do that, i.e. to perform invasive surgery
> on the driver so that it holds sev_cmd_mutex only for the operations that really
> truly need its protection.  Because taking page faults while holding a *system*-wide
> lock is asking for trouble.  Deadlock aside, if one of the user pages being accessed
> happens to be swapped out, tasks could be blocked on sev_cmd_mutex for quite some
> time waiting for the page to come back from disk or wherever.  Rinse and repeat, and
> I wouldn't be surprised if VM creation/boot can stall for hundreds of milliseconds
> or worse.

Hi Sean,

Thanks for catching this. I had a discussion with Tom and Ashish and we agree
that making the CCP driver more granular with it's use of sev_cmd_mutex seems
like the best choice.

I've include a patch (below) that reworks the CCP driver to take this
approach and did some light regression/build testing. Still need to take
a closer look but am planning to post this as a proper patch if the
approach seems okay to you. This mainly addresses /dev/sev IOCTLs since
KVM/internal users use sev_issue_cmd_external_user() which does not do
any copy_to/from_user()'s and is basically a direct firmware call which
is the latest point where sev_cmd_mutex is needed.

I don't have a reproducer for the specific ABBA in question though; I'm
confused at why sev_ioctl_do_platform_status() / SEV_CMD_PLATFORM_STATUS
would trigger a gmem fault (outside of malicious/intentional case) since
it is just querying status on behalf of host userspace and storing the
result in userspace buffer where there's no reason to use a guest/gmem
page. Was this test specifically set up to do this or was this reachable
from a normal path? Just trying to see if there are interactions I'm
failing to consider here.

> 
> The alternative would be to take sev_cmd_mutex around the kvm_gmem_populate() call
> in snp_launch_update(), but even if the CPP maintainers were willing to provide hooks
> to allow that, I'm not willing to take such a hack in KVM.
> 
> So, very sadly, I think in-place conversion is dead for 7.4, and will need to be
> revived on top of an overhaul of sev_cmd_mutex locking.
> 
> Or I guess maybe a less painful temporary workaround would be to disable support
> for SNP if in-place conversion is enabled.  That would avoid extending the in-place
> conversion bottleneck for TDX, pKVM, and CCA, without having to take a gross hack
> to make SNP play nice.
> 
> E.g. this as a workaround for 7.4 (not yet tested)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index fad72cab76cf..df885b8214d4 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3213,6 +3213,14 @@ void __init sev_hardware_setup(void)
>  	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>  
>  out:
> +	/*
> +	 * FIXME: Allow SNP with in-place guest_memfd conversion once the PSP
> +	 * driver no longer takes its global mutex outside of mmap_lock (which
> +	 * leads to deadlock with sev_gmem_post_populate()).
> +	 */
> +	if (gmem_in_place_conversion)
> +		sev_snp_supported = false;
> +
>  	if (sev_enabled) {
>  		init_args.probe = true;
>  

I would hate to hold everyone else up due to an SNP issue that
(hopefully) already has a potential fix. So, if it comes to that and
hard decisions need to be made, it would be great if we can just disable
SNP specifically. The above approach seems reasonable to me.

Thanks,

Mike

From: Michael Roth <michael.roth@amd.com>
Date: Mon, 12 Oct 2026 14:32:28 -0500
Subject: [PATCH] crypto: ccp: Don't hold sev_cmd_mutex when copying from/to user pages

(Proper commit message pending)

This can lead to deadlocks and slow performance. Copying to/from
userspace pages so handle that outside of the criticial path.

The only bit of awkwardness here is that sev->snp_initialized also
relies on the sev_cmd_mutex(), so in that case push the related checks
down into the critical path. This currently results in
sev_ioctl_do_snp_set_config() potentially doing an unnecessary
copy_from_user() before it reports the original ENODEV error in cases,
whereas before it would report ENODEV before doing the copy. This can be
improved upon based on the fact that sev->snp_initialized can only be
set a specific points in time rather than being truly dynamic.

Suggested-by: Sean Christopherson <seanjc@google.com>
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 73 ++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index f833cb7e4da3..ecbc9dfda6e5 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1914,6 +1914,8 @@ static int sev_ioctl_do_reset(struct sev_issue_cmd *argp, bool writable)
 	if (!writable)
 		return -EPERM;
 
+	guard(mutex)(&sev_cmd_mutex);
+
 	/*
 	 * The SEV spec requires that FACTORY_RESET must be issued in
 	 * UNINIT state. Before we go further lets check if any guest is
@@ -1946,7 +1948,8 @@ static int sev_ioctl_do_platform_status(struct sev_issue_cmd *argp)
 
 	memset(&data, 0, sizeof(data));
 
-	ret = __sev_do_cmd_locked(SEV_CMD_PLATFORM_STATUS, &data, &argp->error);
+	scoped_guard(mutex, &sev_cmd_mutex)
+		ret = __sev_do_cmd_locked(SEV_CMD_PLATFORM_STATUS, &data, &argp->error);
 	if (ret)
 		return ret;
 
@@ -1965,6 +1968,8 @@ static int sev_ioctl_do_pek_pdh_gen(int cmd, struct sev_issue_cmd *argp, bool wr
 	if (!writable)
 		return -EPERM;
 
+	guard(mutex)(&sev_cmd_mutex);
+
 	if (sev->sev_plat_status.state == SEV_STATE_UNINIT) {
 		rc = sev_move_to_init_state(argp, &shutdown_required);
 		if (rc)
@@ -2014,14 +2019,23 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
 	data.len = input.length;
 
 cmd:
+	mutex_lock(&sev_cmd_mutex);
+
 	if (sev->sev_plat_status.state == SEV_STATE_UNINIT) {
 		ret = sev_move_to_init_state(argp, &shutdown_required);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&sev_cmd_mutex);
 			goto e_free_blob;
+		}
 	}
 
 	ret = __sev_do_cmd_locked(SEV_CMD_PEK_CSR, &data, &argp->error);
 
+	if (shutdown_required)
+		__sev_firmware_shutdown(sev, false);
+
+	mutex_unlock(&sev_cmd_mutex);
+
 	/*
 	 * Firmware will returns the length of the CSR blob (either the minimum
 	 * required length or the actual length written), return it to the user.
@@ -2042,9 +2056,6 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
 	}
 
 e_free_blob:
-	if (shutdown_required)
-		__sev_firmware_shutdown(sev, false);
-
 	kfree(blob);
 	return ret;
 }
@@ -2318,18 +2329,22 @@ static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp, bool writable)
 	data.oca_cert_len = input.oca_cert_len;
 
 	/* If platform is not in INIT state then transition it to INIT */
+	mutex_lock(&sev_cmd_mutex);
+
 	if (sev->sev_plat_status.state != SEV_STATE_INIT) {
 		ret = sev_move_to_init_state(argp, &shutdown_required);
 		if (ret)
-			goto e_free_oca;
+			goto e_unlock;
 	}
 
 	ret = __sev_do_cmd_locked(SEV_CMD_PEK_CERT_IMPORT, &data, &argp->error);
 
-e_free_oca:
+e_unlock:
 	if (shutdown_required)
 		__sev_firmware_shutdown(sev, false);
 
+	mutex_unlock(&sev_cmd_mutex);
+
 	kfree(oca_blob);
 e_free_pek:
 	kfree(pek_blob);
@@ -2372,7 +2387,8 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd *argp)
 		data.len = 0;
 	}
 
-	ret = __sev_do_cmd_locked(SEV_CMD_GET_ID, &data, &argp->error);
+	scoped_guard(mutex, &sev_cmd_mutex)
+		ret = __sev_do_cmd_locked(SEV_CMD_GET_ID, &data, &argp->error);
 
 	/*
 	 * Firmware will return the length of the ID value (either the minimum
@@ -2430,7 +2446,8 @@ static int sev_ioctl_do_get_id(struct sev_issue_cmd *argp)
 	data->address = __psp_pa(id_blob);
 	data->len = user_size;
 
-	ret = __sev_do_cmd_locked(SEV_CMD_GET_ID, data, &argp->error);
+	scoped_guard(mutex, &sev_cmd_mutex)
+		ret = __sev_do_cmd_locked(SEV_CMD_GET_ID, data, &argp->error);
 	if (!ret) {
 		if (copy_to_user((void __user *)argp->data, id_blob, data->len))
 			ret = -EFAULT;
@@ -2492,19 +2509,29 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 	data.cert_chain_len = input.cert_chain_len;
 
 cmd:
+	mutex_lock(&sev_cmd_mutex);
+
 	/* If platform is not in INIT state then transition it to INIT. */
 	if (sev->sev_plat_status.state != SEV_STATE_INIT) {
 		if (!writable) {
 			ret = -EPERM;
+			mutex_unlock(&sev_cmd_mutex);
 			goto e_free_cert;
 		}
 		ret = sev_move_to_init_state(argp, &shutdown_required);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&sev_cmd_mutex);
 			goto e_free_cert;
+		}
 	}
 
 	ret = __sev_do_cmd_locked(SEV_CMD_PDH_CERT_EXPORT, &data, &argp->error);
 
+	if (shutdown_required)
+		__sev_firmware_shutdown(sev, false);
+
+	mutex_unlock(&sev_cmd_mutex);
+
 	/*
 	 * Firmware will return the length of the blobs (either the minimum
 	 * required length or the actual length written), return 'em to the user.
@@ -2535,9 +2562,6 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 	}
 
 e_free_cert:
-	if (shutdown_required)
-		__sev_firmware_shutdown(sev, false);
-
 	kfree(cert_blob);
 e_free_pdh:
 	kfree(pdh_blob);
@@ -2605,7 +2629,8 @@ static int sev_ioctl_do_snp_platform_status(struct sev_issue_cmd *argp)
 	if (!argp->data)
 		return -EINVAL;
 
-	ret = __sev_do_snp_platform_status(&status, &argp->error);
+	scoped_guard(mutex, &sev_cmd_mutex)
+		ret = __sev_do_snp_platform_status(&status, &argp->error);
 	if (ret < 0)
 		return ret;
 
@@ -2623,6 +2648,8 @@ static int sev_ioctl_do_snp_commit(struct sev_issue_cmd *argp)
 
 	buf.len = sizeof(buf);
 
+	guard(mutex)(&sev_cmd_mutex);
+
 	ret = __sev_do_cmd_locked(SEV_CMD_SNP_COMMIT, &buf, &argp->error);
 
 	return ret;
@@ -2639,12 +2666,14 @@ static int sev_ioctl_do_snp_set_config(struct sev_issue_cmd *argp, bool writable
 	if (!writable)
 		return -EPERM;
 
-	if (!sev->snp_initialized)
-		return -ENODEV;
-
 	if (copy_from_user(&config, (void __user *)argp->data, sizeof(config)))
 		return -EFAULT;
 
+	guard(mutex)(&sev_cmd_mutex);
+
+	if (!sev->snp_initialized)
+		return -ENODEV;
+
 	return __sev_do_cmd_locked(SEV_CMD_SNP_CONFIG, &config, &argp->error);
 }
 
@@ -2677,7 +2706,8 @@ static int sev_ioctl_do_snp_vlek_load(struct sev_issue_cmd *argp, bool writable)
 
 	input.vlek_wrapped_address = __psp_pa(blob);
 
-	ret = __sev_do_cmd_locked(SEV_CMD_SNP_VLEK_LOAD, &input, &argp->error);
+	scoped_guard(mutex, &sev_cmd_mutex)
+		ret = __sev_do_cmd_locked(SEV_CMD_SNP_VLEK_LOAD, &input, &argp->error);
 	kfree(blob);
 
 	return ret;
@@ -2702,8 +2732,6 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	if (input.cmd > SEV_MAX)
 		return -EINVAL;
 
-	mutex_lock(&sev_cmd_mutex);
-
 	switch (input.cmd) {
 
 	case SEV_FACTORY_RESET:
@@ -2747,14 +2775,11 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 		ret = sev_ioctl_do_snp_vlek_load(&input, writable);
 		break;
 	default:
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	if (copy_to_user(argp, &input, sizeof(struct sev_issue_cmd)))
 		ret = -EFAULT;
-out:
-	mutex_unlock(&sev_cmd_mutex);
 
 	return ret;
 }
-- 
2.43.0


> > [ 2260.466972] ======================================================
> > [ 2260.473150] WARNING: possible circular locking dependency detected
> > [ 2260.479329] 7.3.0-smp--ce115a0096358-seanjc-soink #75 Tainted: G     U     O       
> > [ 2260.486981] ------------------------------------------------------
> > [ 2260.493161] sev_snp_vmsa_pu/24505 is trying to acquire lock:
> > [ 2260.498821] ffffffffc01f7900 (sev_cmd_mutex){+.+.}-{4:4}, at: sev_issue_cmd_external_user+0x39/0x60 [ccp]
> > [ 2260.508387] 
> >                but task is already holding lock:
> > [ 2260.514213] ffff93c9dd1cf070 (mapping.invalidate_lock#4){++++}-{4:4}, at: kvm_gmem_populate+0x18c/0x300 [kvm]
> > [ 2260.524275] 
> >                which lock already depends on the new lock.
> > 
> > [ 2260.532446] 
> >                the existing dependency chain (in reverse order) is:
> > [ 2260.539917] 
> >                -> #2 (mapping.invalidate_lock#4){++++}-{4:4}:
> > [ 2260.546878]        down_read+0x3d/0x160
> > [ 2260.550716]        kvm_gmem_fault_user_mapping+0x43/0x180 [kvm]
> > [ 2260.556663]        __do_fault+0x3f/0x110
> > [ 2260.560588]        do_pte_missing+0x515/0x1000
> > [ 2260.565035]        handle_mm_fault+0x7f2/0x1290
> > [ 2260.569567]        do_user_addr_fault+0x47d/0x6c0
> > [ 2260.574271]        exc_page_fault+0x67/0xa0
> > [ 2260.578458]        asm_exc_page_fault+0x26/0x30
> > [ 2260.582991] 
> >                -> #1 (&mm->mmap_lock){++++}-{4:4}:
> > [ 2260.588997]        __might_fault+0x59/0x80
> > [ 2260.593096]        _copy_to_user+0x23/0x60
> > [ 2260.597197]        sev_ioctl_do_platform_status+0x50/0x80 [ccp]
> > [ 2260.603116]        sev_ioctl+0x220/0x2b0 [ccp]
> > [ 2260.607560]        __se_sys_ioctl+0x6d/0xb0
> > [ 2260.611749]        do_syscall_64+0xfe/0x460
> > [ 2260.615933]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > [ 2260.621506] 
> >                -> #0 (sev_cmd_mutex){+.+.}-{4:4}:
> > [ 2260.627426]        __lock_acquire+0x160d/0x2940
> > [ 2260.631957]        lock_acquire+0xf1/0x300
> > [ 2260.636050]        __mutex_lock+0x8f/0xdf0
> > [ 2260.640147]        sev_issue_cmd_external_user+0x39/0x60 [ccp]
> > [ 2260.645982]        sev_gmem_post_populate+0x189/0x230 [kvm_amd]
> > [ 2260.651901]        kvm_gmem_populate+0x1ed/0x300 [kvm]
> > [ 2260.657066]        snp_launch_update+0x1a7/0x250 [kvm_amd]
> > [ 2260.662551]        sev_mem_enc_ioctl+0x371/0x3d0 [kvm_amd]
> > [ 2260.668036]        kvm_vm_ioctl+0x52c/0x580 [kvm]
> > [ 2260.672761]        __se_sys_ioctl+0x6d/0xb0
> > [ 2260.676946]        do_syscall_64+0xfe/0x460
> > [ 2260.681133]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > [ 2260.686706] 
> >                other info that might help us debug this:
> > 
> > [ 2260.694695] Chain exists of:
> >                  sev_cmd_mutex --> &mm->mmap_lock --> mapping.invalidate_lock#4
> > 
> > [ 2260.706077]  Possible unsafe locking scenario:
> > 
> > [ 2260.711993]        CPU0                    CPU1
> > [ 2260.716520]        ----                    ----
> > [ 2260.721052]   lock(mapping.invalidate_lock#4);
> > [ 2260.725498]                                lock(&mm->mmap_lock);
> > [ 2260.731503]                                lock(mapping.invalidate_lock#4);
> > [ 2260.738463]   lock(sev_cmd_mutex);
> > [ 2260.741868] 
> >                 *** DEADLOCK ***
> > 
> > [ 2260.747778] locks held by sev_snp_vmsa_pu/24505: 3, last CPU#35:
> > [ 2260.753785]  #0: ffff93c9d54bd3a8 (&kvm->lock){+.+.}-{4:4}, at: sev_mem_enc_ioctl+0x73/0x3d0 [kvm_amd]
> > [ 2260.763083]  #1: ffff93c9d54bc0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: snp_launch_update+0x145/0x250 [kvm_amd]
> > [ 2260.772991]  #2: ffff93c9dd1cf070 (mapping.invalidate_lock#4){++++}-{4:4}, at: kvm_gmem_populate+0x18c/0x300 [kvm]
> > [ 2260.783356] 
> >                stack backtrace:
> > [ 2260.787718] CPU: 35 UID: 0 PID: 24505 Comm: sev_snp_vmsa_pu Tainted: G     U     O        7.3.0-smp--ce115a0096358-seanjc-soink #75 PREEMPT 
> > [ 2260.800310] Tainted: [U]=USER, [O]=OOT_MODULE
> > [ 2260.804668] Hardware name: Google, Inc.                                                       Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
> > [ 2260.818127] Call Trace:
> > [ 2260.820579]  <TASK>
> > [ 2260.822687]  dump_stack_lvl+0x54/0x70
> > [ 2260.826351]  print_circular_bug+0x2e4/0x300
> > [ 2260.830537]  check_noncircular+0xf5/0x120
> > [ 2260.834553]  __lock_acquire+0x160d/0x2940
> > [ 2260.838565]  ? __lock_acquire+0x65e/0x2940
> > [ 2260.842664]  ? rcu_is_watching+0x11/0x40
> > [ 2260.846587]  ? trace_sched_exit_tp+0x25/0xb0
> > [ 2260.850861]  lock_acquire+0xf1/0x300
> > [ 2260.854440]  ? sev_issue_cmd_external_user+0x39/0x60 [ccp]
> > [ 2260.859928]  ? lock_is_held_type+0xc7/0x120
> > [ 2260.864112]  ? sev_issue_cmd_external_user+0x39/0x60 [ccp]
> > [ 2260.869599]  __mutex_lock+0x8f/0xdf0
> > [ 2260.873178]  ? sev_issue_cmd_external_user+0x39/0x60 [ccp]
> > [ 2260.878663]  ? pfn_valid+0x89/0x220
> > [ 2260.882155]  ? pfn_valid+0x1fb/0x220
> > [ 2260.885736]  ? lookup_address+0x49/0x70
> > [ 2260.889577]  sev_issue_cmd_external_user+0x39/0x60 [ccp]
> > [ 2260.894890]  sev_gmem_post_populate+0x189/0x230 [kvm_amd]
> > [ 2260.900289]  kvm_gmem_populate+0x1ed/0x300 [kvm]
> > [ 2260.904938]  ? snp_bind_asid+0xd0/0xd0 [kvm_amd]
> > [ 2260.909561]  snp_launch_update+0x1a7/0x250 [kvm_amd]
> > [ 2260.914528]  sev_mem_enc_ioctl+0x371/0x3d0 [kvm_amd]
> > [ 2260.919493]  kvm_vm_ioctl+0x52c/0x580 [kvm]
> > [ 2260.923706]  ? kvm_gmem_ioctl+0x192/0x1e0 [kvm]
> > [ 2260.928266]  __se_sys_ioctl+0x6d/0xb0
> > [ 2260.931930]  do_syscall_64+0xfe/0x460
> > [ 2260.935595]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > [ 2260.940822]  ? trace_irq_disable+0x25/0xc0
> > [ 2260.944921]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > [ 2260.949972] RIP: 0033:0x474bdb
> > [ 2260.953031] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> > [ 2260.971770] RSP: 002b:00007ffd188ac3f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > [ 2260.979337] RAX: ffffffffffffffda RBX: 0000000028691b30 RCX: 0000000000474bdb
> > [ 2260.986468] RDX: 00007ffd188ac4a0 RSI: 00000000c008aeba RDI: 0000000000000007
> > [ 2260.993600] RBP: 0000000000135000 R08: 00000000004d50b8 R09: 00000000004e1b78
> > [ 2261.000734] R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffd188ac4c0
> > [ 2261.007867] R13: 0000000000137000 R14: 0000000028693db0 R15: 0000000000137000
> > [ 2261.015001]  </TASK>
> > 
