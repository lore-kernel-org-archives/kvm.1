Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784176;
	b=I1VqfUaPWe5NjITbexboNKkwshlsv3ffBfDHJU+pV104Zd3ir676L968/MzVfI1/Y03e
	 vO7kaP74fLcDpATVm5fr9kS6ibEyUPDW6akdpf03mgOKIhKFW0WdzH2n0E6DlzO23Hhoo
	 bjlnyToWZWzl1Yo7uD8y2HGnDE1ZswP0R196mE2IYJ6MHRUPwydQQyuB864iYeCPm7lsg
	 U/5QfUjwEvXlPsIxInYdqZXWRMOUUbRENf21WFBOMtLjj01ccvi6oi4ffgy0HF94gxdD5
	 JH9/Ihn8t7I6u6DhqxlkKq4ohKLfGCE/wpF0a9CrlJFPZee9TabNpH2u4EOCjM1rG0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784176;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VCgU5Kg2KvKrAQHYH6tU0m/C/hUcvMv2qP9GBHYvr3o=;
	b=G9MORe3B3wStWoM7Bov8p0/dHuc/tjrR4NBJHk/slek4r8+cWA2ebT8+xWhxeYslr64N
	 smbfMwzuZNU59IKpUKVW9zLLdEDHO1LcGpu/ZeEfH9P1u5dH3+bk42tUj+sXa760ILFUn
	 V62GEuzSEOmA917zd+eWlc2FDEl7uEJAyXUDM0C7ZyGfuOpDCOx1FkEpxQYZjT2FbnAPK
	 2FxXrxNp6ZaJnu5beAmL1etXGBppas2W+pn7n+dZ2zCUETPVcUcLXsG2XQup62LQ9TMuh
	 XY0C3tzRSFaoHKe/FueQh9JIl38mXyzDsddFJC3X/UoJdEQZSJwRjIVRKdygMxMsO1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1NP2Erz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B1C606A31E;
	Fri, 27 Nov 2026 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1NP2Erz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9CD1F00893;
	Fri, 27 Nov 2026 12:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795784175;
	bh=VCgU5Kg2KvKrAQHYH6tU0m/C/hUcvMv2qP9GBHYvr3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G1NP2ErzHAioaVQ+nq2m7ayY7YcxNVkVJBX390lHxNjRrXeEYuztB/tbo/rgHtCrQ
	 CKJDVzC2jFZT+wf5yZOlgXfYlfA6XYXwaitYBHL7K6Yov5uLo1Mp/5mMAtMpVEp6J6
	 o9VeU2wzc0cJcsUJDFY5B3x73p4j7tzuJaDKOJHBOrYbLhfwPmEsBn2enO26FBiPuu
	 FKIHmIbV5+GeNCmnmebxxQgy1ag4A7ecdWd/y4JvGOHSwRvPCG7jCmOxiYTj8S7NmG
	 +tS6HLUhsEpLfhtX3W27g8tiiCOODNEfUdkh9XOS3x7z/CUZOfbG3fPmaIBlz0RTIv
	 qlctJuf5Q13BQ==
Date: Fri, 27 Nov 2026 13:56:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, Alexey Kardashevskiy <aik@amd.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
	John Starks <John.Starks@microsoft.com>, Michael Roth <michael.roth@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tarun Sahu <tarunsahu@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH RFC v3 03/88] mm: shmem: Implement guest_memfd provider
 operations for tmpfs
Message-ID: <20261127-plagiat-bergtour-einfrieren-b73600501aca@brauner>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-3-8484dde66a7e@google.com>
 <20261120-provokant-zyklisch-schutt-55d8eddf2ce4@brauner>
 <awBaeiUw0i-uEQzM@seanjc-mac.roam.internal>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awBaeiUw0i-uEQzM@seanjc-mac.roam.internal>

On Fri, Nov 20, 2026 at 06:34:34AM -0800, Sean Christopherson wrote:
> Eww.  I really, really want to avoid having to update KVM just to recognize a
> new provider, and I shudder to think of the potential module dependency hell we
> could end up in.

I don't think you have to. LUO solves the same thing without file
operations:

* Providers register a handler with the core.
* The core asks each registered handler whether it owns the file:

	liveupdate_register_file_handler(&memfd_luo_handler);

	bool (*can_preserve)(struct liveupdate_file_handler *handler,
			     struct file *file);

You should just do the same here, I think. So put a small provider
registry into core code that is always built in and not into kvm.ko.

Providers register a handler with a ->can_connect(file) callback and kvm
walks the handlers when it's handed a file. This way kvm never needs to
know about individual providers and the providers only depend on the
registry but neither on kvm noor on each other.
