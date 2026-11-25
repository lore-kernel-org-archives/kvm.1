Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628450;
	b=2oJZGdntLEJ5uzvpQwngyZVplScU8Q5ATgNETtWgd632VS7Nif0BJfLBqaUvvkHecFRu
	 AW+OmvTB/oGUnrRyIzsYn649ymQxnSBFu2s2UJPvHSOzXikTWI5OePrMndIZe3uub2x0J
	 /xgcZ2NILhncI/X9Y1iYj8RQMBLp2WsIN9JIioKxzjWGuZN3bATj1+whzaCgo2/4RSFln
	 67Jg4eaaDtulmAV995qtVuLpMGr3SFMcvojemYRVj2P7GwuXgnqqRXNwIKoDEUzEaE48C
	 mwy+iq7IusovEicFJyEswelo5Grbl2juBiAqn1uNObYuIFsQ8yv5nZRxMZOKCOxxqTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
	b=xf3lLIgkvwzuRQf77idPWb5G/xl8rmXLGBXErNmFNp+sAgGDU4p95biN1BnSoAiNZ2e6
	 XlyYlkfFpGIOC3otPgC++KYdGeXiHBM8aDSVQyQcMebHOTpao8AET+gNhuJ4CenkhYuiO
	 R4KKtw1V/NkyS7TCa+hrTV+xeWxLkSB5oZLXBbaqU7hEO8g4iF3u7nY2AJvXHsm0nljqO
	 KKx3LC6sVAnkchAqf1/AUdCBzGOFmVPiZDAGuoxn/b521/AUU618P2z1aSXVz8SQrzFjK
	 vALcyW77BehDA0laWFKGccxyH7T4sJShuagNxq2sKc/r8ht0152fGPz35kzwD0KgwlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qe1hh7b8;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B87606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 17:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39B87606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qe1hh7b8
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b402824d07so4086208a91.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 09:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795628450; x=1796233250; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
        b=Qe1hh7b8uf6iB26Wxe+AiFw3fDV+UQAJ12OvNs/mNAH7+h6iofbGLEeNl7P1CP50zc
         Sb6+t3AeoAWvHdO9y4mQGCEcdMDJJFLT2+mfP5YsospXuYzobceDKaTh08CHKZWXppMU
         YVxpxSYKI1JfSZPYlqCxKtUFNl4Qy4akFIBTpFsHkCxMqc9fz1NaEwcZtXWc3fMSqzRO
         LxcISCRSwcd/Y5+5fTvghS/d7q8R7Zh/2byrrb/C+nzQMojIWHgGPTYXIXnUn0Vje3Q8
         dK/2R1PfcKMqeKVy+rrAE8289LNyf6jcbjSYgljBbOB67evq+FzFZjUgx51u9o7IRqaM
         ZKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628450; x=1796233250;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
        b=pG9m0qu1Q/niOVBiOoEBO14WcHrYuwmUtCTRaOuFKHy9ohIFof+rzgZmYyJmCAhFGS
         CI3OsA0DVwRE9sjot4XqeqrRfi4f01k0XbJoo/HEdlJ6WT9QSk3VCxHqYX3brqT0TfkQ
         JV0NpzxZHID6Qafipo3Q5H5Jc0dF08Y2zZgq8M1XHiHLYOaXvlKo0rQY/9B3CdAbrgeU
         VL8W14C7Gwz9Vm4jTIkiKBoYr2k/4qtEDnRjpYZOuXhI3XrA+sXmYjtkHTnmejjPryvY
         rr4uKM22wRvcleMOsTXZ1OYzyK/aX+9joxVMy9jstcCnLuRi+hhohIkVjxKzgNeHLaJZ
         VLYg==
X-Forwarded-Encrypted: i=1; AL+hErGLimL9u3NWA6QuU3T63SCkxTV4i5FoIU6NLSGI33cEQvPmcU+DeHQGssjEMMKgcULRqfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FZSv2L5mjUM0akq4+SOQJ6yM+mM+nTNo9fEzXaQ2GhLCY0nux
	I7XFfsZpRAsYRD7+8FsdFakXve9HA9GV8SjmOAoLJp9Iqr9E3GdJirm0Q3A3wynwfg==
X-Gm-Gg: AZFdTZeI2RtdNPdqQdUzFEoAk8mBSZ77SjGkS0W8JsN9m7POzXDdxnBn6v9IuIA/9Is
	xPZnY72rFqrzR6KOc80QwQioFVEDlwg19biinCki4aUXx6efmCGDjT82bzvhCIgYUXBh+srPlO8
	HDG4fcDStPw73576N6wvsNeGYCr+XlQCAZSdRpRjGIohycvmM59FDEGKIKQMoQX1JlaEON9T0eM
	0per2oT0O0+ZjeNgrKOxxohTAIvzrfV4yHw7SGRxcMnsxMycqqKKaykcWhLdV22As1liC/NinBE
	K8Tw/N2X/e6QqJDGhcY0pxgrVW2p0U8uqxsTLD20RTc9hNiRmTJ8iMGYj5loVhZWkrcnIoQQ1wz
	wZtD/FQk8fPGL4B/C1a1e/R+/djTsawUxO7WoGK7BJPH7qtVWIyjWinD2QJyo+kKpt3/2C0xRMr
	9PB9tIm/2IaN3o2Xz7Q4+QAfw1e4K3a0HoF59pOiaadL7ZUVwH++Fwc3xP4LOkMIuVWBIDePZA8
	wf7ANnd7GUf6+BqEtC7hBYgGE3bj9WvXlRHnDrjSqcu04r+7jk+naRvHL3l4NCp8xlIpf/5ixZq
	dhivmd3a4JerxO9ye6Ba7aHzm7lYiBkadKVIZt5AAsJV7G+80cChwX7dcQpVF9Wx
X-Received: by 2002:a17:90b:390b:b0:3b3:fe22:2745 with SMTP id 98e67ed59e1d1-3b41c933edamr18216503a91.45.1795628448898;
        Wed, 25 Nov 2026 09:40:48 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm31676002a91.15.2026.11.25.09.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:40:47 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 09:40:47 -0800
Message-Id: <DN4H5ST3X9L1.3IUEC1CA5QI8H@google.com>
Cc: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
 <2vxz4idb1i2w.fsf@kernel.org> <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
 <2vxzld6hx97g.fsf@kernel.org>
In-Reply-To: <2vxzld6hx97g.fsf@kernel.org>

On Wed Nov 25, 2026 at 6:43 AM PST, Pratyush Yadav wrote:
[...]

> So I wouldn't want to support slab until we have file handlers that
> churn through a lot of preserved objects.

Makes sense. If KHO slab isn't coming, then I'm fine with the arena.

One thing I realized is that the choice between the two is visible to
the incoming kernel. With separate allocations, the incoming kernel has
to free struct kho_vmalloc and struct memfd_luo_ser separately. With
the arena, it must only free the top-level allocation. So we should
pick one now (while memfd is bumping its compatible string anyway)
rather than switching later.

Separate allocations leaves the door open to KHO slab but wastes memory
in the short term. It's not obvious to me which direction to go :)
