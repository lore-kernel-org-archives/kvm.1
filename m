Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558F38CFED;
	Tue, 15 Sep 2026 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512981; cv=fail; b=opBXL2p1Kev8BICNQZbeMihDs18LgaL1TBTHWYhozuP69e4sNrhs4otIjmRnk2NjKN6oeuzHhOmaqQsMJrCJAVC1JcjAhAnFm+SngErwZfi+pjlj3/zZrLTIaigESX9gGi+DeNekMlBCOJPoR2hWRBrx408htTG7VA0Y3ah3uPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512981; c=relaxed/simple;
	bh=WGHEOGQMajCJFBXcHat1bvU8SSBDetKepzL/B8kTm9A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfH5ZQgUqIUOhcq171WS0CWE1cpu3fcThXVybUj3X3ks1ennTTvnasSMyKwZAx+cZuw2E4sq4H5qcxxpg0jfubNdB+jCUm+rr/GC7Nm4adDGJ0InU6zyNUQjIYai2Mm3ny0vZ1d+eWFIbwJIENhOfKJWYu5ZlsQzA5+vO6XJx+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e3Rvsr7f; arc=fail smtp.client-ip=52.101.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3Rvsr7f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKrOTnwwgd5nPzeu2dRGlF4HAtzPDQmzraf4QxGgHuJiaOWbU33+EzJcdEWc5o7rCPEDf0AN17CBttiR/8AwWnfDoFxUwtuPm93B9wl+HkcTD20C5BkiLhrde5P2OdAeeh1wrHMlCRYYbtDvyh6gxPRKEzKMzmFrhXDwohehl2Cc3i8WqLH1/HO0kRu3OUbMkUKFJ/8ZjUegrOAykbKFdnzA7NRW7g5vZVGQgeCDzNBw0aLwLaXgc3PF3yLrMm3zinAj889d/V8hwXAR+rliY3U3rrnRa80sCObbev5Q69iA42rQcGumMMjdiaMjRSYXOEbDTUduyPNG1Xbv8GHRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om7RktLR97GbQAwowH2MJL++JiaHh2XoLCZlk/s/UPg=;
 b=qPDyiDfoFoolzXHRHInJtqz4+FZSc8sMegRnBUU1xRlnj7gyguKd7lu4hw1wRDB2t5z8H1qz+9pqF21uB0wNQl05aAx6iV+GL4cgwfdHZbmn2K5RP87Zg6jKfRJPfT47cRFg8Zm1eyNPAIMzJnqEedr/EtzF6S3uZr/e06DPmut8bz/0iYgzGp7D4CApS7Du5GaJL7T3JEtTQM4fDqtLyCzL8ChXqqaage/hiAG2DQUG0ku+FGRAJZIK4HJyRlsYsfJmzblAYSVsD87efZSZw+igdC2o01P0j5wJ/7dwQCWxWa5D9EfUxto5cpCQZaNwQGWZxg3+dtVEORgh2WEXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om7RktLR97GbQAwowH2MJL++JiaHh2XoLCZlk/s/UPg=;
 b=e3Rvsr7fr+x62L/Q/39jxJ72onU6QyrDdVf1d5W2R3vzupmYAFOpdzIlhvHMDtHxR39diEqDPC0iMx+sVO7bXe84TyRsYGXa/2/4e2cvIxkCuz+1o/2yWZ0QnpLF0cO8NTJlOWsD7H1F/BiHF7RrxSmBzv4rn01TC+MB7SpEvdppoeXKn3kRT1TFpKJwJVqSAoxcL8+PPC29j0SJn0V9OyjvjsZQR8W1gkGN6cxwVrIp8mJ8VQ/NsR0DuJ4dZQU9SpEq9V8FoMPeTLzqwZx1Avdjv9uceOtkL5Q49xrNvMdK4p3Zp9nkHPJvTfpQtiL+koozP7sL5XhSVh6zhUPMVA==
Received: from DSZP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::16) by
 LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:56:06 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::8e) by DSZP220CA0009.outlook.office365.com
 (2603:10b6:5:280::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 22:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 22:56:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 15:55:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 15 Sep
 2026 15:55:42 -0700
Received: from inno-x280 (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Tue, 15 Sep 2026 15:55:23 -0700
Date: Wed, 16 Sep 2026 01:55:16 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<acourbot@nvidia.com>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
Message-ID: <20260916015516.32d0af0a@inno-x280>
In-Reply-To: <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
References: <20260905081116.106613-1-zhiw@nvidia.com>
	<20260905081116.106613-13-zhiw@nvidia.com>
	<DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
	<20260914121217.70fa0d93@shazbot.org>
	<DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
	<20260915120148.7548a8ca@shazbot.org>
	<DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f55287f-3068-4df5-5a3d-08df137c864f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|82310400026|376014|1800799024|56012099006|5023799004|11063799006|4143699003|10067099003|18002099003|6133799003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Ll+75FVaXeZmsEdrn5B+JrbZyv1Q40C6CLNJWyasS2MxbYv2bHrm/UKVt3Ob1MoF0BQy2tIJTEoSwzHIdeZgoscdMqrEovuCg9KxPe/DG3JzGZdhKVHNcVvDbi40PUejtT9JiB3xf/r4Lx75aiy5AnTduLbnGb16qtrWvNpvlkFIryCIRPAIwVjJoqh2vtcEbexsjkTLN252GbpOvlrNcAywmHQ9nWCj5TKJK/YVpnihuSetBd5ALtCmFUPzXXMeU0SSpXIreS8+a1YQ+xKq5VisA9SkAjFz6oan3l1WnsqID3yUAsYNHuIOA+GXl6e5PMCGvwkXrE5O3iq6D/8syniM8i02H1JDYXRHcsebkUAAcfXMswpKj8tnWXxsHrJ6BSTchd6LsH1VVhTxRXTYhNmFV2XyOHsnwNOnkzyY4J4sGwd+eWdIKefzTsfjGwRxBoYodZVXZmjBdu+zTbvP+JARuNEi/gxAG42GmoYtUyLuUZ4J7RlRgFSJENu8guklOy9fGQlxUl7U9BU2K9M/wwGWjh+MykKD9YjjVjagZXxo50BNuWQGEBm3xAvzc3KDFloWZR74KTMKaiE79AKiahCJ4llnj0wOcjCSRT+jfzYDeM+NvBMMNQL9aauvWNeh1PumTjVKhJEQfpzyiOQbr7rQLRArnDfhqFgIu6ojR8z9hP3p8qhxUVgsvInJyLnfZGX6k7uRWWex+FERhlnOhQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(82310400026)(376014)(1800799024)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(18002099003)(6133799003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UkREBcL/dDH2uICKBN+SeS5kzlOwbKksJpROoY3UkcoZ4jwvvv3/DKdTL51Qt5fYaA8LfNh1V4szp32ZrndSLNI5jtKVNI3ytNr91vOr6rbXP3wl2K7EcFMK2iC78vAF5L+CHOATQwVYHfyayeRmdbE2wg9JJv2X0sW3cekMQDlgyR1HpdNkrr+PkdX3DXTyk9fBXO+QFbVPZ/+NIiQ4rYrT7JaHPRGo+OL+5UzzvZxDVuyueSwDpYxY5Mb7NFJ2WiKyFnFdgNotBXUAbbVmsooukYxHJBnL/5cAF3OstUETem6cSGzPJEnZ+uxuMSXsnIOUY+qRQXn5cI0fynQ8W/DaVzZRvooIxaI/P9vvitEmi+JWaeM+RUQzB9jd4GYgaO/Uo94914dGdSSP6hCwzSbVSOXd1c9iuGvBLa5DvFqA9okCOGrsUleJfwN4OtRu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:56:05.8465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f55287f-3068-4df5-5a3d-08df137c864f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418

On Tue, 15 Sep 2026 23:19:01 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

Hi folks:

Since my name has been mentioned several times in this loop, It would
be better I chime in besides re-spin my patches.

Danilo, thanks for putting the PoC together. I am interested in working
it thorough and some parts of idea has already been in my rust SR-IOV
rework patches [1]. I am already contributing to nova-core and working
on the vGPU manager and VFIO driver, so I can help with nova-core
integration and testing.

Alex, I take your concerns about review and ongoing maintenance
seriously. I'm happy to help evaluate the PoC while those questions are
being discussed and commit on the parts of what you think are
maintainable and reasonable. For now, I've updated the existing C
series to use the new SR-IOV support and incorporate your review
feedback [2]. I'll keep following up on the remaining comments.

[1] https://lore.kernel.org/all/20260915205659.76841-1-zhiw@nvidia.com/
[2] https://lore.kernel.org/all/20260915211811.84790-1-zhiw@nvidia.com/

> On Tue Sep 15, 2026 at 8:01 PM CEST, Alex Williamson wrote:
> > On Mon, 14 Sep 2026 23:36:24 +0200
> > "Danilo Krummrich" <dakr@kernel.org> wrote:
> >
> >> On Mon Sep 14, 2026 at 8:12 PM CEST, Alex Williamson wrote:
> >> > Hi Danilo,
> >> >
> >> > On Fri, 11 Sep 2026 22:39:16 +0200
> >> > "Danilo Krummrich" <dakr@kernel.org> wrote:
> >> >  
> >> >> Hi Alex, Jason, Zhi,
> >> >> 
> >> >> On Sat Sep 5, 2026 at 10:11 AM CEST, Zhi Wang wrote:  
> >> >> > NVIDIA vGPU VFs require their open, reset, and close
> >> >> > lifecycle to be coordinated with the PF-side nova-core
> >> >> > driver.    
> >> >> 
> >> >> [...]
> >> >>   
> >> >> >  drivers/vfio/pci/nvidia-vgpu/main.c   | 253
> >> >> > ++++++++++++++++++++++++++    
> >> >> 
> >> >> This is going to be a longer response; sorry about this in
> >> >> advance.
> >> >> 
> >> >> Looking at the FFI boundary introduced in the previous patch,
> >> >> I'm concerned that it translates the driver model relationships
> >> >> we've expressed through Rust's ownership and lifetime model
> >> >> back into raw pointers and lifetime assumptions that callers
> >> >> must uphold. It also introduces manual lifecycle management
> >> >> across the boundary, rather than preserving nova-core's
> >> >> RAII-based ownership model.
> >> >> 
> >> >> I think implementing the NVIDIA vGPU driver in Rust would let
> >> >> us preserve those relationships across the interface, make
> >> >> lifecycle management less error-prone, and fit naturally
> >> >> alongside nova-core and nova-drm.  
> >> > [snip]  
> >> >> 
> >> >> If you've made it this far, thanks for reading through this
> >> >> long write-up. I hope you find it useful. Please let me know if
> >> >> you have any questions or thoughts.  
> >> >
> >> > I can't really say I made it this far with comprehension, but
> >> > thanks for the effort ;)
> >> >
> >> > The one piece here that I can actually review is [5], where
> >> > dev_get_drvdata() is replaced with a vfio-pci-core struct pointer
> >> > embedded in the struct pci_dev, which is a non-starter as far as
> >> > having a common PCI-core shared by various drivers.  
> >> 
> >> Well, that was just a quick hack to get it out of the way. :)
> >> 
> >> I think there are a couple of options.
> >> 
> >>   (1) Make the PM helpers take a struct vfio_pci_core_device * in
> >> the first place and let the driver forward to the helpers in its
> >> own PM callbacks.
> >> 
> >>   (2) Provide an (optional?) driver callback that translates a
> >> struct pci_dev to struct vfio_pci_core_device.
> >> 
> >>   (3) Provide a macro for drivers to define PM ops, letting
> >> drivers provide the function that translates struct pci_dev to
> >> struct vfio_pci_core_device.
> >> 
> >>   (4) Give struct vfio_pci_core_device its own PM domain (which is
> >> probably a bit overkill :).
> >> 
> >> I understand that the idea is to hide the PM handling in the
> >> vfio-pci framwork, but I think the existing implementation is a
> >> bit of a layering violation, since class device implementations
> >> shouldn't impose requirements on the bus device private data
> >> layout.
> >> 
> >> I also think that the approach to fully hide it in the framework
> >> is only really worth if it doesn't otherwise impose subtle
> >> requirements on the driver (such as the layout requirement of the
> >> bus device private data).
> >> 
> >> Thus, I'd personally just go with (1) as it is the most honest
> >> approach in terms of driver layering. But I think (2) is a good
> >> alternative that is not more invasive than asking drivers to set
> >> the bus device private data to struct vfio_pci_core_device *.
> >
> > I'd position this more as a library convention than a class layering
> > violation.  vfio-pci was originally one driver, vfio-pci-core was
> > pulled out to enable device specific support, ex. migration, in a
> > more manageable way.  struct vfio_pci_core_device is not strictly a
> > class, it's the object used by the library that variant drivers opt
> > to use rather than re-implementing vfio-pci from the ground up.
> >
> > The conventions of that library mean variant drivers get things like
> > VGA routing and power management for free, in adherence with how
> > these features are exported by the core, and can choose to opt-in
> > to common error handling.
> >
> > The use of drvdata is part of that convention and audited by the
> > core such that failed compliance is rejected on registration.
> > Clearly we could allow variant drivers to provide ops for their own
> > callbacks and export core helpers they can use, but only a Rust
> > driver requires this and we need to figure out how to do this
> > without degrading the audit in the core.
> 
> The driver_data pointer in struct device is defined to be a pointer
> where a driver can store *arbitrary* data for the duration the driver
> is bound to this device.
> 
> This is an API contract the driver core provides for the struct
> device structure when used in a bus device (such as struct pci_dev),
> i.e. it is an API contract between the driver core and drivers in
> general.
> 
> It is *not* the Rust driver core code breaking a convention here. The
> Rust driver core code just relies on its own subsystem's API contract.
> 
> The fact that the vfio-pci-core forces vfio-pci drivers to only ever
> store a struct vfio_pci_core_device pointer there re-defines the
> driver core's API contract and therefore is a layering violation.
> 
> > Turning vfio-pci-core into a proper class to be able to have a real
> > layering violation claim seems like a much larger project.
> 
> What you are describing rather sounds to me as if struct
> vfio_pci_core_device wants to be two things: a bus device layered on
> top of a PCI device and a class device around struct vfio_device. But
> in this case it should implement a real bus on top of the PCI bus.
> 
> Currently it really is a wrapper around struct vfio_device (and
> therefore a class device) which is bending the purpose of the
> driver's bus device private data pointer to make a connection with
> the real bus device underneath.
> 
> >> > My concerns are of course who is going to review the Rust
> >> > vfio-pci variant drivers from a vfio perspective, not just a drm
> >> > driver viewpoint.  
> >> 
> >> I did put some considerations about this; I think Zhi would be a
> >> great candidate for this. :) And as mentioned I can also take some
> >> of the responsibility, but I also want to be honest about the fact
> >> that I have a lot on my plate already.
> >
> > And that's part of the problem, there are bandwidth issues all
> > around and neither you nor Zhi are, as of yet, core vfio
> > contributors.
> 
> That is true, but I suggest to also see it from the perspective that
> this effort is a good chance to get more people to engage with the
> VFIO subsystem in the first place and eventually become experts that
> also contribute to the C core.
> 
> For the Rust abstraction, there are two competencies needed:
> knowledge about writing a VFIO driver (which Zhi clearly covers) and
> knowledge about the driver model and its Rust implementation
> specifics as well as the Rust ecosystem in general (which is why I
> offered myself to take responsibility).
> 
> Remember the VFIO abstractions are translating the C VFIO driver APIs
> to Rust APIs for Rust drivers. They don't need to mess with VFIO
> internals.
> 
> >> > Who is going to be responsive when the interfaces break and
> >> > monitor vfio proactively to prevent such breakages, and how do
> >> > we avoid derailing feature development in the core code base.  
> >> 
> >> In practice we shouldn't see any breakages with the Rust code that
> >> wouldn't also break the C VFIO drivers. If this would be the case
> >> it would mean that the Rust code relies on guarantees that none of
> >> the C drivers rely on, which would likely mean that is was never a
> >> guarantee that was actually promised by the VFIO core code.
> >
> > s/practice/theory/
> 
> As mentioned above, the abstractions are translating the C VFIO
> driver APIs to Rust APIs for Rust drivers. I.e. they don't use other
> API than the C drivers use. Thus, code breakages should be limited to
> what I mentioned below.
> 
> >> There may be cases where Rust code breaks, and C code won't, but
> >> those should be mechanical things, such as a type mismatch where
> >> Rust is more careful, e.g. if we'd change a CPP define to an enum,
> >> etc.
> >
> > This seems like a very optimistic outlook.  I don't have experience
> > with Rust to claim otherwise, but I do have general software
> > experience to be suspicious of anything sounding so clean.
> 
> I maintain some subsystems that have Rust code, and I also maintain
> Rust code of subsystems I otherwise do not maintain. I haven't seen
> anything break so far other than for the reasons already mentioned.
> 
> Of course, that doesn't mean that mistakes can't happen. For
> instance, we could have the case that the Rust code makes assumptions
> that the subsystem never guaranteed in the first place. But that'd be
> something that could also happen for any other driver and it would be
> a bug in the Rust code that the maintainers of the Rust code have to
> take responsibility for.
> 
> >> > Can a Rust vfio-pci variant driver be self-contained, or to what
> >> > extent does it impose on the framework, such as the drvdata
> >> > idiom.  
> >> 
> >> As mentioned above, I think this one is more of a layering
> >> violation in the vfio-pci-core; class devices shouldn't impose
> >> layout requirements on bus device private data.
> >> 
> >> The reason C drivers can get away with it more easily is e.g. that
> >> C relies on procedural cleanup and that all responsibility for
> >> managing lifetimes sits on the drivers themselves, so it is easier
> >> for them to adjust. But in general, it wouldn't work out if all
> >> class device registrations or other core primitives would have the
> >> same expectation.
> >> 
> >> For Rust specifically it is that the driver core controls the
> >> lifetime of the bus device private data, which is a fundamental
> >> requirement to e.g. represent registrations as RAII types. E.g.
> >> the vfio::pci::Registration has to be stored in the bus device
> >> private data, such that it is guaranteed to be correctly destroyed
> >> on driver unbind.
> >
> > I see, so driver core has its own convention for how Rust drivers
> > must use drvdata.
> 
> As mentioned above, the driver_data pointer of struct device is
> specifically reserved for drivers to store arbitrary data while they
> are bound to the device.
> 
> The only difference is that in C it is a convention and drivers call
> dev_set_drvdata() themselves, whereas in Rust we do it in the driver
> core code.
> 
> Note that clearing this pointer is also done in the driver core in C
> in device_unbind_cleanup().
> 
> >> To get back to your question, a Rust vfio-pci variant driver
> >> should be self-contained. The interface sits in the abstraction
> >> that translates the C driver API to a Rust driver API. It
> >> sometimes can help quite significantly (e.g. in terms of how
> >> complex the Rust code needs to get in order to actually be safe)
> >> if the C code does a minor adjustment, but it shouldn't be
> >> necessary.
> >
> > It's not clear to me to what extent these abstractions hinder our
> > ability to evolve and refactor the C code.  It may not "lock in" the
> > core API for variant drivers, but it seems it raises the bar that
> > any significant code refactor likely needs to refactor the
> > abstraction layer, potentially the Rust variant driver itself,
> > which imposes a burden on the vfio community that has so far not
> > introduced Rust into the code base.
> 
> In general, if the refactor does not affect C drivers, it shouldn't
> affect the Rust API either.
> 
> If the refactor affects C drivers, it will also affect Rust drivers
> and the change in the Rust abstraction could also be more complicated
> than the change required in the C drivers.
> 
> The reason is that we design the Rust APIs at minmum in a way that
> any arbitrary usage can not produce undefined behavior. Beyond that,
> we also always try to design them in a way that it also at least
> encourages correct semantical use.
> 
> So in theory, it could happen that we need to figure out a new way to
> abstract the C API in way that can't produce undefined behavior.
> 
> But if that happens it should be something minor, e.g. a new callback
> which requires a new type state, an argument that requires a new type
> carrying some invariants, etc.
> 
> The biggest part of the abstraction is the integration in the driver
> lifecycle, which is a repeating pattern. For instance, if you look at
> the fwctl Rust code it looks almsot the same.
> 
> From my experience maintaining both C and Rust code I can also tell
> that good design is pretty straight forward to abstract in Rust to
> produce a safe API; bad design isn't.
> 
> Where good design means APIs with defined ownership, clear lifetime
> relationships, and a consistent API surface. Whereas APIs that have
> unclear ownership and lifetime relationships and inconsistent API
> surfaces are a huge pain in the butt to abstract.
> 
> The reason is that Rust needs to get those things straight somehow in
> order to provide a safe API surface. I.e. an underlying bad API
> design (as defined above) needs the Rust implementation to make quite
> some stretches.
> 
> >> For instance, the only addition to the driver core we have is an
> >> additional callback in struct device_driver, and in the future an
> >> additional pointer in struct device_private; none of those
> >> couldn't be worked around in some way though.
> >>
> >> On the other hand there are examples where the Rust introduction
> >> motivated design improvements on the C side, or bug fixes for
> >> issues that were caught while writing a safe abstraction. For
> >> instance, we recently had some fixes around dyn IDs in the PCI and
> >> USB core, which both were motivated by Rust code.
> >
> > I have no doubt that integration with a more structured language
> > would lead to various improvements.  However, it doesn't seem there
> > are resources to support it in the short term.
> 
> As mentoined above, there are people volunteering now. Without
> starting it, it can't scale further than that. :)
> 
> >> > FWIW, AI can only go so far to support reviews.  Having the code
> >> > insight to ask the right questions is essential.  A human in the
> >> > loop is a requirement.
> >> >
> >> > Additionally, if we can't narrow the device matching to only the
> >> > Nova-core supported VFs,  
> >> 
> >> Agreed, and I think that should be possible. Is there a particular
> >> case you think of where this wouldn't hold?
> >
> > The modalias scheme only matches on vendor/device ID, subsystem IDs,
> > base/sub class, and interface.  Nothing in the PCI spec requires
> > that the VF device ID is different from the PF device ID.  Variant
> > drivers will often present a larger match surface to avoid the
> > ongoing maintenance overhead of listing explicit device IDs.  Such
> > an approach here would put us in the position I noted in the
> > previous reply where the Rust variant driver needs to fully support
> > these devices via vfio-pci-core on day one.  Binding GPU PFs to
> > vfio-pci is a current, valid use case (VFs for some vendors as
> > well).  Thanks,
> 
> My understanding is that in order to support PFs being bound to the
> variant driver the only thing necessary would be to fall back to the
> vfio-pci-core callbacks. If that's the case, my PoC code can already
> do that.
> 
> However, I don't really see the use-case; you can't load nvidia-vgpu
> without nova-core in the first place, so it would require to unbind
> nova-core through sysfs force unbind, no?

