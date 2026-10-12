Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D18497B95
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817641; cv=none; b=JdEWFaAh28t1n/petxQvGaLBisOwWfcQ3nHORAjMINxtg4Alnp9aGrZ3GB2I5dxPS7ijq84vzeSz8b59a1ddAJanM5OvL65MAEWh+ZYHpj3B9w5oc3dtOH9rShGV6R4Ks2/vgYNIyyFh/e3AP+YFewoeO8Ec6OzJlYn3yStt2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817641; c=relaxed/simple;
	bh=tsVU21nxAD5GAzHrBR7QE3ds3Y9VaK8s6sj4rTQ/imc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qebWM676FN+VP+PDyMcPvmqvdjIrQaylz2LbjGNkuk+2AykUe3+fTe/Srhy/RvY1p/zgpN7XzBu1/Z4OsQyAf6RV1rPbcT6WPDx3U36J6YkSXet6pphD7z+5d9w4y4u0SZBKF09CQhpHSxIcE7RHfUjIwZ/GebNmqIdMu1Lmspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyAGQb79; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyAGQb79"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b042c0759so1505387f8f.2
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817638; x=1792422438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tsVU21nxAD5GAzHrBR7QE3ds3Y9VaK8s6sj4rTQ/imc=;
        b=LyAGQb79u9R7nttKMdtpi1fPGlIprpgO1689zl1kD4q9v/P9aIA9FyvLTNRzqFikU7
         8UfrtJ1F/z64nyCqVP0vEykm1I6IDNUbhx1wn/yIoe1qlAJZPW9am9eb0WhXzBoIelI9
         MSQN3ORBsfYyhEGem0TxoFRCGo+DpjeD8jZky4EUJd2YlQM9fP/ot1eoVbYVgTXbzZAv
         1KD35A+sZ8s7hz3Kp8xCb/QKo1KxZJpqUHvJ7KQh/yyxVN0VPIzmyAp6t/3M1rKnbCIC
         4FKfRV21UWUFXOBiSPlE+P+hrxUgmDQUgKr1tD3j0PtJTepy1r/oRPq/Vx7RhLCy8f0e
         glpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817638; x=1792422438;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsVU21nxAD5GAzHrBR7QE3ds3Y9VaK8s6sj4rTQ/imc=;
        b=awKb+60EZ0dxRMKYu62nK+T8541cBjvu84+rBKW7GS1q3CiX+Ewo2PJSnnGcWn/R4t
         qARpdSGDHk4xFXSMW/nCGcbCi5PeR+DwJmw19UYyxyQKH6nzu0wlV5b3v/5q30RkNGxO
         PZTne3U8HRSvZLK3xXvZfJKE9kfJmpICi4/gvHMQ/7R/pq8SZbY3mid3Dg2jtZVYWg/o
         daYUWgQkx/b4BcDrTEG4/V992k+7tq8e6Eje/yCIokSByfD4/8ABTsN6EY6vXIPQfK0O
         +ChgyJ+dqGU48u6mo7hTCYdmh59mS0GQ/IIImWxkUHKjOof245px6+fORzUZSq/VQTR9
         SChQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhzNNFv/3E4Ywhtk7dhQe5btG5aRcNVpHeLUUtjTZ9kyQ9YAxlQAQuMppM1cxrDXNL5/k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkXlu4IusMgonEWwS4/LjuL+Ux/K0xTYkrWZOU9jzUqSbNai0G
	gsovWcTPrgSOj/vYtWdUPRALikhREb2ZIE394zvbUJpdId62zr/u2Mec
X-Gm-Gg: AYBFou0BRbPdS7Grm7EePcJTj7UOAOvfVniBINAcoen2SF6kdX+asbE1sHl1EOpLMlt
	el397njF6NDwcWF1VUVquzlRVntE9Ht2OT8524/BR0Y3ukv6PI21UgE8vNkpGyD5V9t3dBaJSVm
	NdcIHKem+4mgHpzk8LXpDOdZwYlhjXVfjisIWaiJ+06HIeRQWY4Bo5H/64aUuPqWX8BHpMH8jGH
	R78gOykJai9Ah698g0yhY/EaQWO1z+7tkGtKvpoDZ5P+9TFp7mIiXqFZoApFh1xjR3ZSj4rVOo6
	qJFX5i8tweA+iwW6ljgu/LYsVqkzkBx41P3BsuJ4QcqjqqQUcQ8u0oq/H4eDT5ncJ/Q62ldoW2g
	yHCUNHP1hGTGvcF0Mw8Ihw5zaOZG++9XzUVyFHQdjw8MGIbhIPJFfRqQW265h2ragtID6Ro5h2+
	pRNTccXM7a9Y++PPCfpVB3PsbR/Eq7dxHtpjqvShK1rpPxmpuOXAYkcsOtLwdArbX6S6uG35Em2
	bZmYibS3C+3sBdZCjGjYYfuRXiAuIpSlku+RgKvWSy60WsvEdiHW0Z4Ph0kHTo6QzwQ7hy+0Sc5
	cB4yOahYT+OuZZmpxNJK9yGmZjQgALzr9P6iHb+ybXdQHw==
X-Received: by 2002:a05:6000:29ce:b0:48c:6fa4:fc89 with SMTP id ffacd0b85a97d-48dbaadb050mr12203015f8f.12.1791817637606;
        Mon, 12 Oct 2026 08:07:17 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48ddaefa06esm3451088f8f.20.2026.10.12.08.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:07:16 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
Date: Mon, 12 Oct 2026 15:07:15 +0000
Message-ID: <20261012150715.25132-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAEvNRgF1hMz+4ivH6WhsEOLTJGOegYO9AYK6OByYysPp_nVJ=g@mail.gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com> <yq5ald8680t2.fsf@kernel.org> <20261012095800.50250-1-griffoul@gmail.com> <CAEvNRgF1hMz+4ivH6WhsEOLTJGOegYO9AYK6OByYysPp_nVJ=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ackerley Tng <ackerleytng@google.com> writes:

> Wait, is there some magic done to make struct pages represent different
> frames, as in PFNs? In your model, the struct page <=> PFN mapping
> doesn't stay constant?

No, our memory has no struct page: it is a carve-out hidden from the
host with memmap=. I meant the mapping from guest_memfd file offset to
PFN. The PFNs never change, only which file and offset they back.

> Do multiple VMs map the same physical memory at the same time, or is it
> a move like below?

Mostly moves: a page has one owner at a time. There is also a share,
where a parent keeps a range and gives a child a view of it, so two VMs
can map the same frames for a while.

> I'm thinking that if guest_memfd wraps your provider, then your provider
> can issue a revocation to guest_memfd (ctrl-f for
> kvm_gmem_provider_revoke in [1]) on the move source guest_memfd inode,
> then wait for an allocation request from the move target guest_memfd
> inode.

For the guest, this series works the same way: the provider revokes the
range on the source, and the target's next guest fault asks the provider
for the frame. Devices are different, because a device may not support
faults. So the provider also revokes the range on the target once it
owns the frames, and iommufd maps them right away. In other words, a
revoke means that the frames behind a range changed, whether they went
away or arrived.

> guest_memfd is going to support preservation [2]. Tarun's series just
> preserves memory from guest_memfd's default provider (buddy allocator)
> now. For your provider, I imagine the preservation flow would preserve
> whatever metadata in guest_memfd (like the attributes in the maple tree)
> and then go on to notify the provider to preserve some range of PFNs (or
> folios). Your provider would then basically do nothing, since those PFNs
> already survive a live update.

Yes, that would work for us, as long as guest_memfd does not also have
to save the offset to PFN layout: the provider keeps it across the
update, and guest_memfd can ask again afterwards.

Thanks,
Fred
