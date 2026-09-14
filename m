Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1845B367B84;
	Mon, 14 Sep 2026 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409548; cv=none; b=JRoz0XJEQ3sKAm7XEwVU0JEZAwU3BHzaWZ0Wdv4bLHV8A2uiejAePJ2bir/3VteQs3oolQozJwySIHmshB+9zUuOnTTDef58U09gt24GstfJONOVaHzpDXUFzSQYxBPoTf0EgMbluAyivvN7ZRDJMn/Sgu4rRBrj7kR9miPKr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409548; c=relaxed/simple;
	bh=IeXpUMO76ygdrOAltxPvlm2Z7418oPYikyabhnuUduM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eM17FZT8t+iijyWqs7CZ7imEZeNnsGZgwXK6YEM1PJc8VcMK6NdTWuJfMh2/1oQ4qdY+Hc1hooPD8xN/ARoro/FDxcOJq1np7ZhTVIS+c01VN/csNYkrYykAU18BoEZkwe6pnaeOKE7jrZIKsa5kZP84NoNnqJmC3hQnCJ9l0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ZYeeXvki; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYhHjGWW; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ZYeeXvki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYhHjGWW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CDBA71D0010E;
	Mon, 14 Sep 2026 14:12:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 14 Sep 2026 14:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789409541;
	 x=1789495941; bh=uhgt2UjAMH82kPft487TQbOtNSFV2LQEnnMytprdY1A=; b=
	ZYeeXvkicwFVMITURRnA49FSnVibbeLFPHJ46HHQqNGOIxcuZ78GwYrfTTX7HvO4
	u6x7Z37Fwnc+EQzntgf0fIEh3yfCKkCsxRdWjr9Seoa8VBpwD3zDcSgq+HyiqtA5
	SLLo+8so+GgFsxnsvRx9JVFncLmreu+7sfAwPeBD4Le0v10lYas49hAkXk5RmkU7
	v6Sg/5DxA7Vh/hUb8x6ZV7nREG/TPilHgcilZSmnFsUDUfRb4e5/GV0UzPQfN85h
	585JOc9UHQmxPtqTLtf7nX7BYVgw/fPqGmY9pOLGT0J2ZBtgICLXxJfT2vHqYhix
	cUuwyaiTMMJ/wPzyWiWgZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789409541; x=
	1789495941; bh=uhgt2UjAMH82kPft487TQbOtNSFV2LQEnnMytprdY1A=; b=N
	YhHjGWWydaa2JAaM3UMHFmqWfc0O5I6UVCoARBktG2NTkq9UrRIhU5Hgz2bhbhak
	kECEEg741zZJXTCI3XQOp/wyS4MpWDfWfI4Uc+V19yvNSP/4c3Tf6MbzzYSrKf8X
	NoxpkzV0uhuyt6yvV7y0ZFHXJsVfBM6eGdUa7d1CfHRmmcojj2VaNF1rZCQ6a+EB
	y0l58yKMHEble+gRF4g1s5MM/l909RzPOnd3v/26MVTTN39SshOiflZaHmknsoHr
	zBjtlPjVelvy3KoIur++L/urQpW8LoA0U6FbcVXNZWGvz8/A86GIRjYJti8b5HLp
	OVD7TsP3/DfhfCF4szDfg==
X-ME-Sender: <xms:BTmoalZZ9eZ0IGGQaGBUirZJLjLG5fNWXLjPpk9NGNdnBlq0h0UI7Q>
    <xme:BTmoavmq1dDE-As-K1Gg4VL2WDr4_dulKiD6U9pGFdZokMIVfSaClPkWxdCFI7Pm-
    G2JGchhIT4_yvL6IKNUq4uSz8-wS6rfqlL7B7A5grJwnuUYflwc6w>
X-ME-Received: <xmr:BTmoauyXTueIF8wekbV25ToGpeHHY7x8Y6BASM8_GnVBrd-lg2XCT8bRbKuv2A>
X-ME-Proxy-Cause: dmFkZTF2uaYefa6Q6cBEHpcthDToSxPokXFkhkFwYdlt/0NLvJ9XjZ6IvfeAvtLc7dVOTy
    sAHmM2qdAY2xkDTRwXe/+MUpe8DXgx0mdFN8/08msGRTpqW7Bo4+i0m4TxZHgt/h8vtSVw
    C+ZQ6zbTx8uQV9gzDOEo4qBbRyscO3VixkxVExJzSR/TbhJAx8SIIpuocPP2GIATPG5wIi
    2CKBzChTdqtxdGdeion4TvtdVWmIk+BndE8umHXcpPVf1iu8wi8EzLchC2jj30jqgNkmE9
    nPdKwC0EO1nzELx56VTA/qWb6ScSHwOEJCTi0c80+yCmKhGuLESTci2da2CGUlle1+kldy
    40UCaR5Dcqj0nN+u6QOmJ2cBUf7TGuxwUFwtFlNvn/1sKtIOMn5gJMUeazme9RyiQd7Evs
    FKYVq2rKMVmtCvVcKDusfG5p6Rg2TRQ9oWBTp00+xF/H5PraiVhYIfVtEMboaP/Q4vNPQ8
    inJymWt79SBWIolbgqMCEkp0omkgVSnLjuV71tG/8Si6/z+UkgdN0jGJUPM45QisJIiA/y
    MNicVsrpESGws8tNZIbM6kC80dmkiU1JtgD84Oy8Lz1NIVAIuKt+D7KKfkmgXpwd+3GwON
    zkir8DLR4zaUcfoh7apXN1x3/dgb1JJg4sxkYWODJXVmVDK8O3sKXkj3uDzg
X-ME-Proxy: <xmx:BTmoaovUFWyO6umvgb4OOoOXnfvn1879nl0_SRvuLvwOwmwXIBNRuQ>
    <xmx:BTmoai8RNEz_9d6l-ZJR5HAGzZ2vKDSSCC9JzoOYNr4QDN-njPsBSA>
    <xmx:BTmoav2gZN28vgWjr-M8e-2G0gJtR8uc8TKqYdrCInekBVBNy-Cu-g>
    <xmx:BTmoaofBKBotiaEMezZDo9l6KLi43kGTmKoxyDrx5Iaap1KbxWFY3w>
    <xmx:BTmoasQ9spvY5LS3k3J20Ye9BIsXvyhf07KpdgYqtREDJHhGsevf2P8Q>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 14:12:19 -0400 (EDT)
Date: Mon, 14 Sep 2026 12:12:17 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <acourbot@nvidia.com>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
 <kevin.tian@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>,
 <kvm@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
Message-ID: <20260914121217.70fa0d93@shazbot.org>
In-Reply-To: <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
References: <20260905081116.106613-1-zhiw@nvidia.com>
	<20260905081116.106613-13-zhiw@nvidia.com>
	<DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Danilo,

On Fri, 11 Sep 2026 22:39:16 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> Hi Alex, Jason, Zhi,
> 
> On Sat Sep 5, 2026 at 10:11 AM CEST, Zhi Wang wrote:
> > NVIDIA vGPU VFs require their open, reset, and close lifecycle to be
> > coordinated with the PF-side nova-core driver.  
> 
> [...]
> 
> >  drivers/vfio/pci/nvidia-vgpu/main.c   | 253 ++++++++++++++++++++++++++  
> 
> This is going to be a longer response; sorry about this in advance.
> 
> Looking at the FFI boundary introduced in the previous patch, I'm concerned that
> it translates the driver model relationships we've expressed through Rust's
> ownership and lifetime model back into raw pointers and lifetime assumptions
> that callers must uphold. It also introduces manual lifecycle management across
> the boundary, rather than preserving nova-core's RAII-based ownership model.
> 
> I think implementing the NVIDIA vGPU driver in Rust would let us preserve those
> relationships across the interface, make lifecycle management less error-prone,
> and fit naturally alongside nova-core and nova-drm.
[snip]
> 
> If you've made it this far, thanks for reading through this long write-up. I
> hope you find it useful. Please let me know if you have any questions or
> thoughts.

I can't really say I made it this far with comprehension, but thanks
for the effort ;)

The one piece here that I can actually review is [5], where
dev_get_drvdata() is replaced with a vfio-pci-core struct pointer
embedded in the struct pci_dev, which is a non-starter as far as having
a common PCI-core shared by various drivers.

Maybe Dave Airlie can share some experience here with a Rust driver
growing up within a subsystem for a non-Rust-literate maintainer.

My concerns are of course who is going to review the Rust vfio-pci
variant drivers from a vfio perspective, not just a drm driver
viewpoint.  Who is going to be responsive when the interfaces break and
monitor vfio proactively to prevent such breakages, and how do we avoid
derailing feature development in the core code base.  Can a Rust
vfio-pci variant driver be self-contained, or to what extent does it
impose on the framework, such as the drvdata idiom.

FWIW, AI can only go so far to support reviews.  Having the code
insight to ask the right questions is essential.  A human in the loop
is a requirement.

Additionally, if we can't narrow the device matching to only the
Nova-core supported VFs, then this variant driver must immediately
provide feature parity of vfio-pci with pass-through to vfio-pci-core
for matched devices.  Libvirt selects a best matching variant driver by
modalias with our override scheme.

I'd also like to hear from other core vfio contributors.  Thanks,

Alex


> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=poc/vgpu
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?id=484316d855e3d61873122c295feb9a7457eeca21
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?id=6292c1de7f0758dd31496a454b4034507f38bd40
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?id=efac2cec97eab36edd01a2fe79aea67a04bd8842
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?id=76b3bfd6386a01f338780e1a37b5bad3f5a48d31
> [6] https://lore.kernel.org/lkml/20260303-rust-pci-sriov-v3-1-4443c35f0c88@redhat.com/

