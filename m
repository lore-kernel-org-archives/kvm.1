Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253202;
	b=0RVwzxms+/b8/wC8LyjLlWpF7wFwA7WvZCrQZdJqeF7CAzDRxIuVXS7P/E9xROWLXvhL
	 7Jin0EtMIGU5VQ35P8IPiUqs0DhQB3+XRlYjUhRO+gMl2f0D+Lralw+3dku7+t+S201NP
	 4UpQguSZV0+6TfYuauF4hdOOC7PWusZySLkjzS3gOk1vjjxKkHjHTKs5YE060rFzzYT8W
	 SzZZIjV0Nitb2bzJlhuBSw15kPLVNZGC+1PYubk7z6aCOVUUgcXVycVJU5utDC3Nq9FEw
	 T23F07ORCMDNpTIV1J914ysXC0L0psodEoeyN+1K7shnh+FGvnseJxfffz/hPg3euvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253202;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=uj4lN0l73poxUX+FmN14sN+KhrHh46mzInZ+w/lSNOA=;
	b=SRZYU5uvlW28be0OVZrmfYdcqrqYYSqa0W7QjGGDq0txgnJ1oAzzGCqFEBTIM9VpupRV
	 68lC9SH8hnNK8qcVvxCfh6Ijx30jLGqNcTOOZCFKuTpmCpuJx9itUT95OPRRmyUDXgObB
	 oDa+ZMsqOf+e017nH4CezbWSsh5EJuBgzzfEmoAiANQtki9w2FEusZMGwSqxDky93+QAX
	 IGLRWiOllhBWf9sGQXHrJQUjeskEPO2rXA0Xkc0QCbiQcLYleNlHr2xKh/Kb/i+Om0ccN
	 fxmEd7vg37YaWzCoQOJV0zzao8U1Y748cNa2OMt732eu/QtUBp5+LlPAdgx/eG+DA6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4UzML0E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F394606A31A;
	Thu, 29 Oct 2026 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4UzML0E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE01B1F01829;
	Thu, 29 Oct 2026 05:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253202;
	bh=uj4lN0l73poxUX+FmN14sN+KhrHh46mzInZ+w/lSNOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=f4UzML0ErVF+LAoa1vMt9mZJRViUBFoCp4qAhid0FJ375+eCUkscN3nrQ+SxHaHIc
	 WuoEBI1IRIIMzX5ZITRFCo+KBtNHOYAKcxiWsH2bHbiIUUSzfWMG4Agl65uvlKgCUE
	 4GkmPhPZ3f1jP1zxDZKdwb0zCtl8JXPgilBKrUWyIBu+ShSYeJ2VMD1zYSKTZGZXBB
	 pxp58kmWohBUeeSTsbk4tvKWW3S8UqZj/30T4z8+6DjJsgRm8l2O4LbUYA00UHN7yZ
	 8gmiRO3pPcVPpm9q+uwqGjTkcbyU3tstmRuUbpdDyudJr9ey2cv7XmwTAY/POea5pe
	 +0f9fSCBfw89g==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Fred Griffoul <griffoul@gmail.com>,
	Gregory Price <gourry@gourry.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	llvm@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH RFC v2 00/50] guest_memfd alternative providers
In-Reply-To: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
Date: Thu, 29 Oct 2026 11:22:59 +0530
Message-ID: <yq5ah5i5aw90.fsf@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

> Here's RFC v2 of guest_memfd alternative providers, continuing from "Allow
> guest_memfd to be created using a resource (pool) fd", which I'm considering
> RFC v1.
>

 [ ... 138 lines skipped ... ] 

>
> Aneesh, thanks for your series [4], I haven't got a chance to look at it yet. I
> will before I continue this prototype for IOMMU. I want to get feedback on this
> part first.
>

I am looking at rebasing my series on top of this one.

One detail we need to finalize is memory access through resource_fd. For
a VFIO fd, I believe we want to continue allowing access through that
fd. This means allowing read/write/mmap/ioctl, with the VFIO subsystem
accessors checking whether the memory is host-accessible before
accessing private PFNs [1]. My series denies mmap through the guest_memfd
fd.

https://lore.kernel.org/all/yq5a1p9qxmqg.fsf@kernel.org


-aneesh
