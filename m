Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331E1D7E41
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468894; cv=fail; b=t8hs7v2e+0IYqgysFFy9LdpUUaxm51N8a0g1PxU1yc+CiCOQg9u832N1zirPgC+btAH3KPLDGOdnnmZISxCWrsw2CCx8UNR2xERHkhO59WXETXAr3KA8RH5nY6y3jmaPfa1KI6JIHamxvh1PeV3zV4FCPblMzQdufSBFQnKSAgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468894; c=relaxed/simple;
	bh=SPNP5Dbg0fmBMNpUh+7Id6hWSlDn8IIob0vPnEGic9M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6xl7bVJpjd/CW27ha4LynbkKcu8dNcCuKJuHkrD/efn9KYGaQDCmt2Vm349x1EZhKhA7hqfi+ieL3Xp2KsJBrZb+9xsv2RLmnr0ZaDZX9VvLil4UwK6WXlew4J+gu+Jn1NLCnonMG89CDTvMxWWzS+ZUevO0AHLQt7PqmUArIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HqANDS7x; arc=fail smtp.client-ip=40.107.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HqANDS7x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYAgbNCiMzGmoLQZa5v/kdnuusjPMRKaU1nkesBgzW3WQ+NZL4+O2d/StXQTVT4hXPqhA3IYFv6gzmZq4O6vG4mmVhdJ1s4jlUVlOGX3uXfUcTZBrStG/P2grhII+cy52VNvo2DLNV7bcQ06umTsqrqVzOhdm109zZxulp68JgFsH79n3tkYFs2lLMgEzSD9+Px1700/z9l7LDqBzg2PZ2h3Zw9jdygpUJsqY2ILgw1tn8dwMcF55TV9wGLq5bbu7gg6N7GDYFPlkQSo3zUcb8h54UQbWRrZcYlGukvzbu0yh+8t0xYmmz6alWDqRzQLg6XBo1yVEhhHEDpf3TV8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjxoXNehdLVCOmxvWEPglgzcXZAl3hGpVV7dtRNo9Qk=;
 b=FnPrUw3lf6n73xJiOd6vnXTrsiXdnONDKReqzXGnEzEj+DwnLKsyH/p7GO4gget6ZzhUJdFun5OkCqM6FNKrFhjVRWU/sA2buJIE0c4nXW2Vzo+5CXgcXdWayWtVFbockgctbjZ9MVs33lj+9JWUlSq3TytH7XCPmDDrbp0HPb1+ihoBui/YxEgCMJLC4Hd3FNfdtCo3jchJHnZGTe5PDgrljANMrkRqdFGyB1M9d3laxvji8J9vfJqVrEHaR1+7ROUS/hexkMmndVnNfJVdXZRLtUs57kbXoJeh3lSPb1rmxDfuyHFD/t5Zv5GXtdWd6qo8/r6Qxm41GEm6ddlfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjxoXNehdLVCOmxvWEPglgzcXZAl3hGpVV7dtRNo9Qk=;
 b=HqANDS7xaQMnk0YNf2eqJn3IQ0d/2Xo5LXoi61HUtP5kvKcRtCsihFyUpC9wpy8HrZ4mf/Pbs2S/w4I3q5qNJ4qP+Kk4mYGuMj2DPwM4l2Tw0Cwwn9jsVRoxEp3GVz4WzwTatEx5tWM002uh1kJFoHzsfgG2RHUmSbQr7woESQU=
Received: from SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:41:26 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::7a) by SA9PR10CA0017.outlook.office365.com
 (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:41:25 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:41:25 -0500
Date: Wed, 3 Jun 2026 01:19:32 -0500
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <pbonzini@redhat.com>,
	<berrange@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: Re: [PATCH RFC 02/12] hostmem: Introduce dedicated memory backend
 for guest_memfd
Message-ID: <ge6uyrbigeoym74thogtolbe3e3jgya7hsibzrrqum6nevusys@ixh7rwe7lzsx>
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-3-michael.roth@amd.com>
 <871pep73o6.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <871pep73o6.fsf@pond.sub.org>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8343ef-1c8d-4512-a4f2-08dec13b2251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|22082099003|18002099003|3023799007|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ouV7Zg3eOrvCq4Z8T7YM1Uf3h1APP8kRAKqtMOL2bChCEVa1QVYBnVE3HiBrKhxJ9B1kgqNgQwiUJ1WItPDQRIEAXAIFbp2hldcsLeTZY+ZJHHBJJWTK95PB8X9V4cOMRLneCieWk8F5wS64oypc4izTVqMF3f2K5k0dMc/ab7o/HIrftzpm9uy+nNUYmhUJeRMkFcrSslqalsUNnWZDcXsOWMFwdtqzD/YLtmLjine2eZnEb+UAxhX86jRq/MwbRWhez8D2ZLwWl9bIbGCdJCIeKMmaI9F3+JJfskR+7js0i8gEPjlVb1By0sDjTx+qGd/4hb73mx/y6KzDIegAoREHz1FRrsTiCtMMuZ9ve/voQWhvTozicyO9wa/3b7jhBJCQnO5bLxvs/P+cuU+Ztub2ytqZDaUdzKHU9jayvvhyQauQ1sbjnhbRDqvoMBlQK1Cx4uy+UikHlLJX4SioHpzeNGL8jzcFACbTNOtpPopE8Nj5HkTKTY9a9qO0mCLsf+cwTAUuOOQVDxCeU6YvNh6CfQ6x0rfQLc2m8jPCBx8XKK8JD/N2sQ3wjbhE3lrMv6LRr1gS7qei5mrPlCju6Mh8hC4Up81JaUALXFQld/XY84rcdsg2EQjqDyQmcTC2ymBZPFFMRgxTRj0P6tGbW+SG52waHOHHlQHIt8JRZnmtHawDtACeV42+4lzjjtQjz8GdQHXc8x0i7N2vmsIuj0WvuU9VCSpLbHdmEn60x/g=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(22082099003)(18002099003)(3023799007)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xtwKSqMX+686HRSoa9+fw50l+AYyPE7sVbwYx3eerukLbf5r1wC9cbTSPwhB7JzpsWGrfFMYNbVTKgYIapKa3L6e1AjMvywrFv9YnRlssfZPQtsNo4qP70WRhDvzvWL7oZIFQPZZ9JqoZ8xIzHDXsHQ/6R1wPHaHHlrD0sxe9NEcJYqbfNwGNOKi0QQb8YugMUULOq44jXGP2YYcKzicYNXdqTCc5ZD47h1OaTixUW8KVros5inXs9qvpIV2UBZF5M3gKu4WNWNzhBDvZCL5B+r+GUs/fu4UtT6zKzsyCb6FV3LwfGJtIBjW1nnEm2SqdVTmS/r088dsTdUdWtXqVrZ/XjNLFhL/dJxDL3XxivKH1hxJfmY5t6I4yES01ICRvgn3Brgbx3JGLozIg+sIaqFHC+T/O9CskgGWQNZiOQXbgs9b+qEMPCe0xUnoCG6Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:41:25.5879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8343ef-1c8d-4512-a4f2-08dec13b2251
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866

On Tue, Jun 02, 2026 at 10:22:01AM +0200, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > In the initial implementation of guest_memfd in the linux kernel, it
> > was not possible to map memory into userspace for direct access; instead
> > the memory provided by the memory backend would be used for cases where
> > a confidential VM wants to access normal/unprotected/unencrypted memory
> > that can be used for shared memory use cases, and for access to private
> > memory a guest_memfd could be associated with the same memslot. A memory
> > 'private' attribute set via KVM_SET_MEMORY_ATTRIBUTES could then be used
> > to have KVM route to the approprate backing memory.
> >
> > In that model, it didn't make sense to introduce a specific backend for
> > guest_memfd, since there was always a generally need to have a separate
> 
> a general need?

Much nicer :)

> 
> > backend type to handle shared memory access/allocation. Instead, QEMU
> > configures the guest_memfd support for the associated memslots
> > internally for cases where it is running a confidential VM.
> >
> > However, with recent changes in guest_memfd kernel support, it is now
> > possible to mmap() a guest_memfd FD into userspace and use it for shared
> > memory, as well as continue to use the same physical pages for the same
> > GPA ranges after they are converted to private ("in-place conversion").
> >
> > To enable the use of this mmap()-able/guest_memfd-provided memory to be
> > used for normal/shared memory instead of just for private memory,
> > introduce a dedicated guest_memfd memory backend that can be used both
> > for confidential VMs that wish to make use of in-place conversion, as
> > well as for non-confidential VMs that just want to make use of
> > guest_memfd for normal memory (which can be useful both for testing as
> > well as a stepping stone to things like software-protected VMs where the
> > host can be trusted to provided some additional degree of isolation for
> > the VM independently of hardware support).
> >
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> 
> [...]
> 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index dd45ac1087..502fafeb15 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -661,7 +661,8 @@
> >  # @share: if false, the memory is private to QEMU; if true, it is
> >  #     shared (default false for backends memory-backend-file and
> >  #     memory-backend-ram, true for backends memory-backend-epc,
> > -#     memory-backend-memfd, and memory-backend-shm)
> > +#     memory-backend-memfd, memory-backend-shm, and
> > +#     memory-backend-guest-memfd)
> >  #
> >  # @reserve: if true, reserve swap space (or huge pages) if applicable
> >  #     (default: true) (since 6.1)
> > @@ -780,6 +781,18 @@
> >              '*seal': 'bool' },
> >    'if': 'CONFIG_LINUX' }
> >  
> > +##
> > +# @MemoryBackendGuestMemfdProperties:
> > +#
> > +# Properties for memory-backend-guest-memfd objects.
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'struct': 'MemoryBackendGuestMemfdProperties',
> > +  'base': 'MemoryBackendProperties',
> > +  'data': {},
> > +  'if': 'CONFIG_LINUX' }
> > +
> 
> Identical to MemoryBackendProperties so far.
> 
> >  ##
> >  # @MemoryBackendShmProperties:
> >  #
> > @@ -1234,6 +1247,8 @@
> >      'memory-backend-file',
> >      { 'name': 'memory-backend-memfd',
> >        'if': 'CONFIG_LINUX' },
> > +    { 'name': 'memory-backend-guest-memfd',
> > +      'if': 'CONFIG_LINUX' },
> >      'memory-backend-ram',
> >      { 'name': 'memory-backend-shm',
> >        'if': 'CONFIG_POSIX' },
> > @@ -1312,6 +1327,8 @@
> >        'memory-backend-file':        'MemoryBackendFileProperties',
> >        'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
> >                                        'if': 'CONFIG_LINUX' },
> > +      'memory-backend-guest-memfd': { 'type': 'MemoryBackendGuestMemfdProperties',
> > +                                      'if': 'CONFIG_LINUX' },
> 
> You could use MemoryBackendProperties here, and drop
> MemoryBackendGuestMemfdProperties, similar to how memory-backend-ram
> is done.

That's true. I think I was anticipating it being warranted at some point, but
that doesn't need to happen here.

> 
> >        'memory-backend-ram':         'MemoryBackendProperties',
> >        'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
> >                                        'if': 'CONFIG_POSIX' },
> 
> Should we provide guidance on when to use which memory backend?  The
> commit message provides some clues...

Were you thinking from a schema perspective, or something more
user-facing?

Either way, docs/system/confidential-guest-support.rst could definitely
use some sprucing up as part of this series, so I can cover this aspect
there as well.

> 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 96ae41f787..3c754c149f 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -5858,6 +5858,11 @@ SRST
> >          off will cause a failure during allocation because it is not supported
> >          by this backend.
> >  
> > +    ``-object memory-backend-guest-memfd,id=id,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
> > +        Creates an anonymous memory file backend object that has similar
> > +        semantics to memfd, but is also usable as private memory when
> > +        running as a confidential VM. (Linux only)
> 
> There is no object type "memfd".  Do you mean "memory-backend-memfd"?

Yes, will update.

> 
> If yes, that one has additional properties @hugetlb, @hugetlbsize, and
> @seal.  Why are they not needed for memory-backend-guest-memfd?

ATM, hugetlb is not enabled for guest_memfd in the kernel. It's likely the
same set of options will apply, but there are also efforts to do things like
plumb DAX memory through guest_memfd for confidential VMs where maybe we end
up needing to be a bit more flexible/creative... not sure, but it seemed
like a good idea to give ourselves a clean slate since the support isn't
there yet anyway.

For seal, I'm not aware of any plan to support that for guest_memfd, so
it seems like unecessary baggage to pull in.

Thanks,

Mike

> 
> > +
> >      ``-object iommufd,id=id[,fd=fd]``
> >          Creates an iommufd backend which allows control of DMA mapping
> >          through the ``/dev/iommu`` device.
> 
