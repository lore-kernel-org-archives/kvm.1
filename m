Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202637;
	b=PcWC0N5HumTDv/VOfxyx8HB8r0mauEkLx3g0nOhUhZp80vPSbgwFyK3Bc68ACGcuA6kk
	 lzIBVz/gHVAlDrG+sU0bIncJdcjjBAkeSs6FRsNVVSKPgY5nA0NXgykeqhiME+pA+Xp3J
	 9EEAMRC9MB25P5QwTe4OJcNyj1QKWDRi9Rjoi6fU3i9kKyKJEOEdjt5d998spteayzZoF
	 3u45JU4MxJYXVs//QsGfbCcdTb5eNpPAObHzeBZgCu9mrfOrk+82VIFSbsqOPvqiLzu1g
	 yR0z5o2nsBLEYmfP0415lKkzHOyuKJkKu+hlPwLQ46Kru2r94Sw77VgInbHqQ4nzE/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202637;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=ozxqwrYfOeA2JdEt8v+EBV8WXqLYW6Q2JhJClZ3mZzM=;
	b=Y1qwk5z3PfcvV/CaqmFCpFlXFN+6COS62SoJbe/ycLZlsRUeh75dNKh0Bjcv7tQx9biO
	 EMjeBZuqjYhZmGr2wGqHO/tyYbt0a9D6StSy9DM+K+ToHFfHge64P1GoYyLPLUBPm+crm
	 r2crpxLPybifTQN/HGpCXaU14AjOcMxk+mQIMckGq2QOgHosSOobRJrSl/FExBjV7cqUj
	 4Lx42surnxyR+KYiZwPbioBz64mU1RiLklw3KDS9z6Vrrgjv7pcWMQfW6EPvHyuhXklph
	 ErDexC2Ac1VtB9/dFPR3o75LVR6XeY1HItld2tutRgHq0RtmZzhYmDk8N+VXigwfEFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFz3Dfvs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6EE606A31C;
	Mon,  9 Nov 2026 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFz3Dfvs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7101F0089F;
	Mon,  9 Nov 2026 05:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794202637;
	bh=ozxqwrYfOeA2JdEt8v+EBV8WXqLYW6Q2JhJClZ3mZzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SFz3Dfvsu49EC0/Dd5enhpMYmWj8WG1Qz9hgpIvpuXDuZX0vSXk4pAuw0K0wF1YuL
	 WwDUfolgUFI2Z95Mj+vypcIBuavxOvqY7PYosR/ytl0T7qH7MNA9Y+7qQ/j1RJ9wZk
	 4SiSD9XqUaDXctIFZTXendxhy90DdI3Bm1WydU9rMuQt9BOTWQ4IR3EsvkyBM8265K
	 3hD7Ly6bu0ZlWsuggqeZ63OE7ec2LVGeSVpc6r9rFJUN87s8qYbt/Ura/kk+s3gp3j
	 6CZzzWR+ksauY3XEPxzy8vViaLj4R4yfzyse28VDdlpdNmS/qXoV5AnmfzBBJgs3GU
	 2jXPec4kDyPCg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jianxiong Gao <jxgao@google.com>,
	John Starks <John.Starks@microsoft.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH RFC v3 87/88] QUESTION: KVM: guest_memfd: Disallow
 private mappings of shared-only PFNs
In-Reply-To: <20261106-gmem-alternative-providers-v3-87-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-87-8484dde66a7e@google.com>
Date: Mon, 09 Nov 2026 11:07:05 +0530
Message-ID: <yq5ase1atvjy.fsf@kernel.org>
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

> From: Ackerley Tng <ackerleytng@google.com>
>
> Host kernel drivers directly write to the PCI MSI-X vector table to
> program and mask interrupts. On confidential computing platforms, allowing
> hardware protection tables (such as RMP, Secure-EPT, or GPT) to mark MSI-X
> pages private causes subsequent host kernel interrupt updates to trigger
> fatal hardware protection faults.
>
> I see 2 options here:
>
> 1. Prevent it at conversion time, and require INIT_SHARED
> 2. Let guest_memfd track all conversions to private as per normal, but
>    block setting the MSI-X range as private at the platform level by
>    blocking platform config for SNP, ARM CCA at fault time, and by blocking
>    faults for TDX.
>
> Implement (2) partially by introducing a PFN attribute bit indicating that
> a physical frame cannot be mapped or populated as private, reporting that
> attribute from VFIO PCI whenever a BAR page overlaps the MSI-X vector
> table.
>

For the TDISP flow, we could initially treat all MMIO BARs as shared.
The guest could then request that a specific BAR range be trusted
through an mmio_validate request. The validation operation could call
set_memory_attribute() to convert only the guest-requested range. This
would allow the guest to control whether the MSI-X table and PBA ranges
are trusted.

Before reporting that the mmio_validate request succeeded, we would also
need to ensure that the BAR range had been marked private and mapped
into the guest VM.This is required for the device to transition to the
RUN state. This also means we should not get a gmem fault on private
device PFN. In my series, I enforce this in the architecture fault
handler.

The host must also be prevented from modifying the BAR attributes
afterward, as that would cause an attested device to transition from
TDISP RUN to the error state. An earlier discussion also considered
whether the guest driver should be allowed to manage BME/MSE. VFIO
currently emulates these, and the conclusion was that the VMM must not
pass it through. Once the device is in the TDISP RUN state, the guest
TSM manages the power state and BME/MSE changes.

-aneesh
