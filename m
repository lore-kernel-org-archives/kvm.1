Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F23D5656
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633402; cv=pass; b=VU0+In0joZXHQZqIKT7VV4/1C5eUKKoBV1uH1nDKT4YYFP8kB70qgS0MLVGvgU0U5lhrOzzcxIY4Y9iYWmra/JZMrJp1/bXWZqfXgLnfxd+SeAi44StY1S5ejQ8CIBOYv3ekJMQHZzPvLKssCWxJTRpAEcQcZs+I4Po0beXuhDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633402; c=relaxed/simple;
	bh=hbZ7AtqKeATB2r4kr93uGgpM+Y/zj6+leroFxw5uOv8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mARvxXTcT0/GAooakcWVe8PfJvarksBQaFEjlToPED4AelVkwNmr7hqGU4GdsG4/dxRh2EJTpw/XB4MEIEVtOUT9ztp5qUSMCei4IzVieW4j92cSQOksk/xA6wXzdi0lRusKhuLOYNflpfSmRfWO/o3x4IAvjSMeDobwo4/3wFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXYp3gXJ; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXYp3gXJ"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137335bc3caso5951162c88.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781633400; cv=none;
        d=google.com; s=arc-20240605;
        b=L2ryKHNBk0BCHW7P4QVvwFBn5Dfb/EUjwRODxHnSXUHWKktBPQCLJKzn7BlyKME36z
         UEzDytUVQe3pBYXKmfHkMpPqC6x11YLfHGqdk8GUFCdETzasH1FBtBJBVBXmyhLoiTUz
         jFnHzAq7AOSiHMnVDbFob1jpUjnOR2+4LOY0vdDAtWSXHtvVwiBdk+O4SJk+6My0qMtp
         6sxPNxT5Cfms4MhNPdyIFJRmDEtoZptttetA+9lub6QiAwfc7V6a+xr2q2/9JLdn71lR
         lVOFEjsVHzh2j6/CbwWWqtyggQGYE4wF426EFOomh8Og9Q8dcfr6qFCmbqzQD4x9pA9S
         w/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=o82nbH8071ZDGLm0iYK2gdlkX600tsvrzfNh6VLN4Fo=;
        fh=t2aLCiRtPljBblaoMfb7+1dBhyC6c/wQ0lgXjx57mB4=;
        b=PxvG3GIbYB54NiudevhWniXdXdN5m6B9sZ3UzAaJ9hm0uMBD383jo1UcLjKK9+lQh3
         5QECUjuuHXc5Pp1fVm06tf3kxJOlMYDMuIqMQkuHkXfZd+pBfVzuQFs/D1lX4gdZBi/8
         ZNkh1tFfw3jZr6DIuriyT8SzYi6HWPrYKGbHuSIXWompOYcjdMzJMnooOYK1Fwrw1Ioy
         qrqDyCm12QN/imMHwjMD9dtEmGqZer7SFCj89fTCjB1nCR8+gYfQQ92QsIqXk8t3cDwK
         InVY0FmpFcd2eNznAPkf+dpFfan+LJqRXvPJqcNri60zCeDyahj+NfAAGWuBblOqXp7J
         Q6mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781633400; x=1782238200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o82nbH8071ZDGLm0iYK2gdlkX600tsvrzfNh6VLN4Fo=;
        b=JXYp3gXJ7pMeF9WaAOYYO6gSbS5mjDcaZxz/wPa+8kEWDLwRfwwM6/7YMe2P9Bahyn
         QWCBOe0P47hudynegfdEKLzfJzJ50p5G9IZzB/TTy8x9k1JR1j7Z6u/j+ICZSpnlxamK
         KwEMdQVsm6CrQVJ9s6SsKMxpPqN8ci892isftjagSgFrlTT+bZ3nzDqyC3alo0ibbE7N
         5Jp5Rzf/kg2KLIWQnSE/R36/vK1J1yPYiSZXIno0NkMP96yH2uT6W0kq5HyLw1RAOs1+
         qwKMzNSkS6pv0v8wqU5fidqR5I1KRaGca9PsyMp/PMygj2YDYxrvI6xwT9ugbtMif/+t
         gbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781633400; x=1782238200;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o82nbH8071ZDGLm0iYK2gdlkX600tsvrzfNh6VLN4Fo=;
        b=BbNBmw69SzaqAGNBP3xijFOQutaTdqzRmBJtCBMauizz5Bdla1K4uiaec13ggg+Ibf
         WHUFOYrs18aQLwVxt16FS9XSl73MBJzzOto0aNnTRv2fB+jscJGIU2o4ASQ8uEGgz1ze
         Q6hHiyUXUTuPi2MiUNlqim3SQl74MxblaaUHwmqhPf7H1S3jIfaVNWQhqsNdWhybjrsf
         d5K+3rnUn/7O73C42sSEpDi/mvBUYuHOnFYRqXUufOjBHkDNQn7M+jYlL2VA2MkgHBpK
         y+jYLduOemhwoAD+U8u31qvgi8GTYTXcw7Z8mpzy1ge7d12EFAfSBz6aaeX2Mua68vdy
         h4dA==
X-Forwarded-Encrypted: i=1; AFNElJ9QYmcS3zOI8Rd46+WR4P1my3RA58yby7Y9mpCwplVXRSelqG95tQDFlZ8tAw5niVH+tbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjF7DFrVZlUM9/DNQjdcrKop186ZbyWvP/UFAX43049Zui3OQI
	dv3E0EG4N3gOHnaz58Jn7aFX2ef6evCw2uLKh0g4/q74hKE6UAk6xZvLbzjH7BUKTWBUOQ80bZ7
	0oP/a0DeKyK5lpAmSQ6Dp2Njw9/9A2+3ERzMH1CVh
X-Gm-Gg: Acq92OFZYK11duZKfhE6w3LXxr7110dB8l8lcMgc0mcnSBP9MZ+sqpSadel9Gu66pf9
	gKsuMe1obpFuTWGNuvtEO3NW+yPHDFkExjcRPKYu9l+naG1fDq/wcKzjLRd9xB10XsHzpACkh0f
	u+BF2DebsaYjGeJ3L1zC9NMVo7PBMF3fXPYsA+ZQiP8/aNgfzySljvsz/AK+uqsTOZj6VPuMnbH
	AnrFPZV69oakBSRXpPY8VipGNVL3evCQVUNOsIZWwNQ7Qxr4RA4DhQiUolNrJBV6D1p2KGPqkCz
	dG8/QVK6LKglmBrkYjPbRABBTAVt5ylK+MMaJNM/IWegQHoePcQIQw2BGUNwPR8TdUC0VkZrIOy
	UmWj0
X-Received: by 2002:a05:7022:622:b0:137:9399:fc59 with SMTP id
 a92af1059eb24-1398f69626amr23221c88.21.1781633399141; Tue, 16 Jun 2026
 11:09:59 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 11:09:58 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 11:09:58 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <1e77f24d-315a-4f68-a109-2f4520343c0c@kernel.org>
References: <20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com>
 <ai_XK__RTXMCEcCG@raptor> <ai_aczmeH2IA6JaB@raptor> <ajA4z_Wkb93cTW4m@google.com>
 <1e77f24d-315a-4f68-a109-2f4520343c0c@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jun 2026 11:09:58 -0700
X-Gm-Features: AVVi8Cfci2aZVOJMaXs8XbxR0646nJUtiwZFbcmm9wi2jMlpzFimiOSyoy_glyY
Message-ID: <CAEvNRgFQLEsKanKrj=ePHoShiY2cgQgxtGs_2CJcZHP=JOjidg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] KVM: guest_memfd: folio migration for
 non-confidential VMs
To: "David Hildenbrand (Arm)" <david@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Shivank Garg <shivankg@amd.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, Fuad Tabba <tabba@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Nikita Kalyazin <nikita.kalyazin@linux.dev>, 
	Patrick Roy <patrick.roy@linux.dev>, Pratik Sampat <prsampat@amd.com>, 
	Ashish Kalra <Ashish.Kalra@amd.com>, linux-fsdevel@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 6/15/26 19:39, Sean Christopherson wrote:
>> On Mon, Jun 15, 2026, Alexandru Elisei wrote:
>>> Hi,
>>>
>>> On Mon, Jun 15, 2026 at 11:43:14AM +0100, Alexandru Elisei wrote:
>>>> Hi,
>>>>
>>>>
>>>> I always thought that one of the nice things about using guest_memfd as a
>>>> memory backend, as opposed to host userspace mappings, is that the host
>>>> cannot unmap VM memory because of KSM, automatic NUMA balancing, hugepage
>>>> collapse, compaction, etc, acting on the host userspace mapping of the
>>>> VM memory, and outside of the VMM's or KVM's control.
>>
>> +1000.  It's not just "nice to have", it's a core design principle of guest_memfd.
>
> Right, and I raised in the guest_memfd call also the rough idea of Alexandru's
> use case of having non-movable guest_memfd pages such that we can support use
> cases where we can hopefully guarantee that a stage-2 mapping will not just
> randomly go away.
>
>>
>>>> I think it would be useful to preserve this behaviour, even in the absence
>>>> of confidential VMs (i.e, guest_memfd file descriptor created with
>>>> GUEST_MEMFD_FLAG_MMAP).
>>>
>>> Just to be clear, I was thinking that it might be useful for both
>>> behaviours to exist (migratable and non-migratable) for non-confidential
>>> VMs, and allow KVM or userspace to decide which they prefer for a
>>> guest_memfd.

More concretely, are y'all pointing towards a
GUEST_MEMFD_FLAG_MIGRATABLE, which will set .migrate =
kvm_gmem_migrate_folio, and for now, error out for CoCo VMs?

>>
>> For the purposes of this discussion, we should separate the physical act of
>> migrating pages from the features that trigger migration.  As I said in last week's
>> guest-memfd call, I am a-ok with supporting page migration as a mechanism, but I
>> am dead set against supporting NUMA balancing, KSM, LRU-based swap/reclaim, and
>> anything else that goes against the goal of guest-first memory.
>
> Right. Page migration for supporting ZONE_MOVABLE/CMA, compaction, memory
> offlining, virtio-mem and possibly some collapse mechanism if we were to support
> THP of some sorts in guest_memfd would are all reasonable.
>

Background question: how would virtio-mem use migration in the host/guest_memfd?

> As soon as we mix in access/lru semantics, we're going into the wrong direction.
>
> Fortunately KSM is anon-only and not even worth a rant here :)
>
>
>
> --
> Cheers,
>
> David
