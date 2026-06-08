Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340438AC65
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951406; cv=fail; b=UJtU5tFtlV18EPMNclaSKoSodrn+uncwnv4N5EDEguPCLiTR+Oj7mEZsKpUe/ik6/mPpCra5rP84VJoF1lshA7Zf2LRNf7OEM6kw7hXu1T3/YX6VyLtE55bIQrnSGbBxKpLS8qJnxg5FX1OiZ9qyz9MW/bJMPbjZxMB7aiBAXTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951406; c=relaxed/simple;
	bh=o2OTfQCVgNjpCIu2Ozux7MwdfkHLFPFpJ5KGORev6e0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH/xndzWmyrAmFw/YkwHLhp7qMKFhVYsC92SscybQaLZA8pV5bQ6exgYlVSrP2K0+KpAbKFt9PHrykvYsKycMyjp4786+vtpHOyuiHHAnBFUvIm32oeO5FiRHeXdnsx/xylGShF5LvBRrfvM4hjm8gban5QNaIArQvfuvuhNrLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TfTXbeyM; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TfTXbeyM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOjnA6tk4dBPVp4++ca/sjTnkMixv0+1q9IkBXI16zbnE/Cvh4yzeVtcvqIU4bEZcLCeBTgLWIl4mPFWZxS6Fdv+EmxgLne7DpFDhvC0bkR5lerZiq0xviQju8Y96UL09T31/HueDH7c6DDT+XQ0kG5KG+NoJu+hcEkPe1E95pGn1nRZ7tpyCGQrTloVE74Dw1Cs7EYiXjzdkumawB6fpP8woGEG+QyckRwRHk2/v0iZoeR/oPPsH6ubqI8uwO62i9T0uaJ3iOPmyGcSnFtnJjWC5JW0F5Mede/cDNo1E3zf5+VB84vDv6Yhx6/k46vIo2+rWRLPQajiCaiWH+Q5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caK17talZkMPn+wrd0iN633O6KBDgREuK95iwT+acX8=;
 b=fPmqziggZzRauZ0GWv2O1qAotUpRzL2mV2BdFAwMie/kzKVoFU3LMszS48+atjZ8s/FAou6ObfD0rueUXbxrT9fPGDz16fqmsXdOemtt0nxOAYB3a1nxWSS1r4AeM12PGmhzEyHNnvzU2FYZWMSSoo86Xrqp59sET3VTXaA3UWZt69ueKPHTH5YQdSGKD3+D47lRTP27auqHjWmlCMXZe2r3nHgo8EQpNto2qDVy8CO+pQ+1i90644tLWf0MKSeiwKsaFqqciQHjXvSXFqu8d5/4U5c14+tk7nHS0M2ZBceR1elUCoj6v3A+RBfiLd5uLOYoetVenzJX4alj6gaOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caK17talZkMPn+wrd0iN633O6KBDgREuK95iwT+acX8=;
 b=TfTXbeyMcRd2w0ppEtFLykkYhCktDzQ7z8HB+BhNTm9SDfzg6LTNSkV0KRhVofcATjMWTRfA1SqPjcg19CEqexDaQO39skVBVQogz8guUslmBsm3OxIfMBrPC6AXbYedb8ww/NjpGLab/gO2sOKep/9Wog0r+BbHYjy0sqLVxl8=
Received: from SA1P222CA0192.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::13)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 20:43:16 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::99) by SA1P222CA0192.outlook.office365.com
 (2603:10b6:806:3c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 20:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 20:43:16 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 15:43:16 -0500
Date: Mon, 8 Jun 2026 15:42:40 -0500
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <pbonzini@redhat.com>,
	<berrange@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: Re: [PATCH RFC 02/12] hostmem: Introduce dedicated memory backend
 for guest_memfd
Message-ID: <ftjw4gdopj7lwhwyzxqqqq4fgnn6qvjec4lkxlgwl4mxx6di6a@hxtznrzho7ui>
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-3-michael.roth@amd.com>
 <871pep73o6.fsf@pond.sub.org>
 <ge6uyrbigeoym74thogtolbe3e3jgya7hsibzrrqum6nevusys@ixh7rwe7lzsx>
 <87v7btl9yx.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v7btl9yx.fsf@pond.sub.org>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba1eed5-2930-4c8c-6d35-08dec59e916d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|13003099007|10063799003|18002099003|22082099003|11063799006|5023799004|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Mv/Zf0AT2yHA6yWlHFwxI37ADs0Lk7daUWmCFBc7h4r7TwQR8HKMS4Ei05OT4BLOUa6OWalTRPRpeFwBMq+JWbprHve9+ZhUFsv4Li+GujFYChneJ/+DUTs+xNaOHfiZ9ay2UEr6EtHarBSy+R2JERA2P0/y0CvMh54MG1LI03g1a01owDVuSxLarVgtkrD1w2C5CCcOPG8pSeUH/HQ4NXURzLM+uc+2hsGyrQAkAvYRHQeTUWoYjmlKI0cPd4kwgOUxej3s6xAp/b+8qiAU9lkZJ1dKylesOIAVMjfaWc+QEjCuNZafe02lua5K7pAgErgA2JRVvpowvqVpczdbAo4CDePYM8QdWDVr8A9aAcxRFz/CH5hKrX2X1ZEB6rNupSjDeS0A/QM3h2KXEyXBwLObb8Xv0pPc8KCW6knjnIh43ksjVk83UR7TsWp2hzxyQtjWaejxxkovKB0avZdIwoDTCTKX2ZGIB34HbYiGpP+j9MrpNPaCUBh7VHd4FbxFljaDGSyXfxG3AsdGBdjOVDBkqO6gI7bCfYyRaopafGs6DndKXBzyyIKALRZzd+FqTQdJt6n1doW/yaFMjwCpKcYmmbstQOcP7QuKyknBSHoQOQR+qfU1TlOF9JXN/I+/z+GGPR9/35b44xGnN1P47iQg1ouU/QmwSFg291FFkiGGVkK/26BqZpcl17XFCsnwOz+sm2XPPb+GLS0Z9WEVuRuwjo5uziZ+LHCfIOZItSM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(13003099007)(10063799003)(18002099003)(22082099003)(11063799006)(5023799004)(3023799007)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MOHOOtl9FCNA+9QGC+gLBKG7fJCWnbsPhe/6RlOUjTp9b/S7OoydsMaNuu/h8Q+XiUt22IijQAp/ciw/Mn3ZFyZriKaxqCuVVsAOlfnO1+rKEnhMB1p5znmFkcvG2T2cuuP4zGahYCi1pExWxYkPB7A56PxNCxj6OVodPsjO8de4gKsbCeuY4JStaX6wddVS6E+b2vW3VlWf56Yc6/UpaXsa0ZCqMhQqAw2bCkjehcMXQei6r/ZgjLbaey0c3sR62s0eP4bFVG0x2TaprP7HP76RM+bSQd9ptyEdbXlyfr0frj6DoH6N1NvpJPZZN4fk/AR0AiSgg0hdQsUiSTCsWsaKRHXD7yLnRsn9AHx27DiCJAmPVUkRer/ujSNRTRMfCd8fwCgH4aucMEsQR1MeJAiHp6uQ2x7K4Ki7FaT/l06OeDzLIc1nmqqDW/mdtcIh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 20:43:16.7943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba1eed5-2930-4c8c-6d35-08dec59e916d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836

On Mon, Jun 08, 2026 at 10:20:22AM +0200, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > On Tue, Jun 02, 2026 at 10:22:01AM +0200, Markus Armbruster wrote:
> >> Michael Roth <michael.roth@amd.com> writes:
> >> 
> >> > In the initial implementation of guest_memfd in the linux kernel, it
> >> > was not possible to map memory into userspace for direct access; instead
> >> > the memory provided by the memory backend would be used for cases where
> >> > a confidential VM wants to access normal/unprotected/unencrypted memory
> >> > that can be used for shared memory use cases, and for access to private
> >> > memory a guest_memfd could be associated with the same memslot. A memory
> >> > 'private' attribute set via KVM_SET_MEMORY_ATTRIBUTES could then be used
> >> > to have KVM route to the approprate backing memory.
> >> >
> >> > In that model, it didn't make sense to introduce a specific backend for
> >> > guest_memfd, since there was always a generally need to have a separate
> >> 
> >> a general need?
> >
> > Much nicer :)
> >
> >> 
> >> > backend type to handle shared memory access/allocation. Instead, QEMU
> >> > configures the guest_memfd support for the associated memslots
> >> > internally for cases where it is running a confidential VM.
> >> >
> >> > However, with recent changes in guest_memfd kernel support, it is now
> >> > possible to mmap() a guest_memfd FD into userspace and use it for shared
> >> > memory, as well as continue to use the same physical pages for the same
> >> > GPA ranges after they are converted to private ("in-place conversion").
> >> >
> >> > To enable the use of this mmap()-able/guest_memfd-provided memory to be
> >> > used for normal/shared memory instead of just for private memory,
> >> > introduce a dedicated guest_memfd memory backend that can be used both
> >> > for confidential VMs that wish to make use of in-place conversion, as
> >> > well as for non-confidential VMs that just want to make use of
> >> > guest_memfd for normal memory (which can be useful both for testing as
> >> > well as a stepping stone to things like software-protected VMs where the
> >> > host can be trusted to provided some additional degree of isolation for
> >> > the VM independently of hardware support).
> >> >
> >> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> >> 
> >> [...]
> >> 
> >> > diff --git a/qapi/qom.json b/qapi/qom.json
> >> > index dd45ac1087..502fafeb15 100644
> >> > --- a/qapi/qom.json
> >> > +++ b/qapi/qom.json
> >> > @@ -661,7 +661,8 @@
> >> >  # @share: if false, the memory is private to QEMU; if true, it is
> >> >  #     shared (default false for backends memory-backend-file and
> >> >  #     memory-backend-ram, true for backends memory-backend-epc,
> >> > -#     memory-backend-memfd, and memory-backend-shm)
> >> > +#     memory-backend-memfd, memory-backend-shm, and
> >> > +#     memory-backend-guest-memfd)
> >> >  #
> >> >  # @reserve: if true, reserve swap space (or huge pages) if applicable
> >> >  #     (default: true) (since 6.1)
> >> > @@ -780,6 +781,18 @@
> >> >              '*seal': 'bool' },
> >> >    'if': 'CONFIG_LINUX' }
> >> >  
> >> > +##
> >> > +# @MemoryBackendGuestMemfdProperties:
> >> > +#
> >> > +# Properties for memory-backend-guest-memfd objects.
> >> > +#
> >> > +# Since: 11.1
> >> > +##
> >> > +{ 'struct': 'MemoryBackendGuestMemfdProperties',
> >> > +  'base': 'MemoryBackendProperties',
> >> > +  'data': {},
> >> > +  'if': 'CONFIG_LINUX' }
> >> > +
> >> 
> >> Identical to MemoryBackendProperties so far.
> >> 
> >> >  ##
> >> >  # @MemoryBackendShmProperties:
> >> >  #
> >> > @@ -1234,6 +1247,8 @@
> >> >      'memory-backend-file',
> >> >      { 'name': 'memory-backend-memfd',
> >> >        'if': 'CONFIG_LINUX' },
> >> > +    { 'name': 'memory-backend-guest-memfd',
> >> > +      'if': 'CONFIG_LINUX' },
> >> >      'memory-backend-ram',
> >> >      { 'name': 'memory-backend-shm',
> >> >        'if': 'CONFIG_POSIX' },
> >> > @@ -1312,6 +1327,8 @@
> >> >        'memory-backend-file':        'MemoryBackendFileProperties',
> >> >        'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
> >> >                                        'if': 'CONFIG_LINUX' },
> >> > +      'memory-backend-guest-memfd': { 'type': 'MemoryBackendGuestMemfdProperties',
> >> > +                                      'if': 'CONFIG_LINUX' },
> >> 
> >> You could use MemoryBackendProperties here, and drop
> >> MemoryBackendGuestMemfdProperties, similar to how memory-backend-ram
> >> is done.
> >
> > That's true. I think I was anticipating it being warranted at some point, but
> > that doesn't need to happen here.
> >
> >> 
> >> >        'memory-backend-ram':         'MemoryBackendProperties',
> >> >        'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
> >> >                                        'if': 'CONFIG_POSIX' },
> >> 
> >> Should we provide guidance on when to use which memory backend?  The
> >> commit message provides some clues...
> >
> > Were you thinking from a schema perspective, or something more
> > user-facing?
> 
> The QAPI schema doc comments become the QEMU QMP Reference Manual, which
> I believe is the first stop for "how do I use this?"
> 
> Sometimes, a full answer just doesn't fit there comfortably.  So we put
> it elsewhere, and point to it from the QMP Reference.

Makes sense, I'll cross reference the documentation and provide some
background on how the backends / options are used.

Thanks,

Mike

> 
> > Either way, docs/system/confidential-guest-support.rst could definitely
> > use some sprucing up as part of this series, so I can cover this aspect
> > there as well.
> >
> >> 
> >> > diff --git a/qemu-options.hx b/qemu-options.hx
> >> > index 96ae41f787..3c754c149f 100644
> >> > --- a/qemu-options.hx
> >> > +++ b/qemu-options.hx
> >> > @@ -5858,6 +5858,11 @@ SRST
> >> >          off will cause a failure during allocation because it is not supported
> >> >          by this backend.
> >> >  
> >> > +    ``-object memory-backend-guest-memfd,id=id,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
> >> > +        Creates an anonymous memory file backend object that has similar
> >> > +        semantics to memfd, but is also usable as private memory when
> >> > +        running as a confidential VM. (Linux only)
> >> 
> >> There is no object type "memfd".  Do you mean "memory-backend-memfd"?
> >
> > Yes, will update.
> >
> >> 
> >> If yes, that one has additional properties @hugetlb, @hugetlbsize, and
> >> @seal.  Why are they not needed for memory-backend-guest-memfd?
> >
> > ATM, hugetlb is not enabled for guest_memfd in the kernel. It's likely the
> > same set of options will apply, but there are also efforts to do things like
> > plumb DAX memory through guest_memfd for confidential VMs where maybe we end
> > up needing to be a bit more flexible/creative... not sure, but it seemed
> > like a good idea to give ourselves a clean slate since the support isn't
> > there yet anyway.
> 
> I gather these properties cannot work today.  I agree we shouldn't add
> them until they do.
> 
> > For seal, I'm not aware of any plan to support that for guest_memfd, so
> > it seems like unecessary baggage to pull in.
> 
> Likewise.

Sounds good, though I'm sort of now leaning more toward the
memory-backend-memfd,guest_memfd=on approach that Peter implemented[1]
since it requires less assumptions about what we'll need to do later
(i.e. if we want to introduce a backend specifically for guest_memfd
we'll still have the option, but if we do it now, but decide to go back
to re-using the existin *-memfd/*-file/*-etc backends because the
option format seems more familiar to QEMU users, then the dedicated
backend is a little bit more of a pain to turn around and try to
deprecate.

Not sure yet what we'll end up doing though, but hopefully for v2 we'll
have a plan for what to do initially at least.

Thanks,

Mike

[1] https://lore.kernel.org/qemu-devel/aiCAFWKEAHkPLCO5@x1.local/

> 
> > Thanks,
> >
> > Mike
> >
> >> 
> >> > +
> >> >      ``-object iommufd,id=id[,fd=fd]``
> >> >          Creates an iommufd backend which allows control of DMA mapping
> >> >          through the ``/dev/iommu`` device.
> >> 
> 
