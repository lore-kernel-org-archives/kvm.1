Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793928173;
	b=o3MklUv7cTvq+jqelVmYOdnRtgvoPULt6PCA+W83KOfAnsB+UgID2rRCnRtIVj67mGXm
	 stgkSDfUtGshBAGBFb0/qRgJTuO0IHlhbw8WeDrSkzjHpeBxXXwwyPbBJaokocUVrFSBV
	 nH16GA2vmtpFek/hACWym6DQ+Ep07+w1NquO6Zs0z2RmlSgZIfzsrChi2dKTC2VFDx6UX
	 ZSji2mRNBMt6UvPyq2K5c+22dUZtS+M3aaEvpfPOngCQM59L1wF7i04KNv64fa95HO0qD
	 Ul6y3l6lEbEJZHUBFbV8gPE1a73eHmj7T6LHLgmgMfl6Kdk87A0vxigIIM7MHEYoQTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
	b=Hv+0LxBw2ZznM3D9mHt3UpmhFs+RjXRk0l7juV01SPbK1EP2mw+hQ3v2goh3Kf9CHwZW
	 1ZN6d2aSP5WLFOfnZuqw8juV36j4CIEtlxoo/uryxqhEhtOSE08wULDoPMxM1clQbmkm1
	 eSxGD6F73LSEayMUkwzmmCPJKcn+8hVRamOejMAiad2VhgYAy5RXPD/hTVpg1aWkc/WFI
	 YBDNFNfBh2hdkVP+SI6DYXjqTHEjDAgQoscKZMxFiK1ii+TJ20sSY9PyqSoZcXgWxyvMC
	 5INV0CnFD8MOrdJ1YLlLpVu1FKkcuYwpV/4rU57iP3fizjuiTF/K/WKlHq45+d3cOTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AD606A32E
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 01:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 442AD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a070755c8cso32041b3a.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 17:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793928166; cv=none;
        d=google.com; s=arc-20260327;
        b=miX5ZFFEm+nwhQXrb0y4CxSYzx5sxBB6gMS7t3bvhNbkfU4tZ/1Ly+U7MGsQyEsBUh
         0Gl/A5ZypoyhCzoE4zsWVVxMj+rD2zFoBN9Mq4P5CjMtx8xEL0d9VSTE9SC2jqEvw5sq
         xWDshEGqiFXd+4gAFBombavML/px0XIeU1c6YekbvZnZSyvnXfG4mzD0/krsP3nJ8/Im
         f3L6JuTZMeXEc2LmAybFba8vNEsIw6B4irki9CPtFUODhllI/3NPf73aZ2W3FkhtVdwx
         s8BmP0ccQtDIj7RK5v1fvYjz6BufEzHXCgGdLs4WC+j2gvt998OAxSDwxkxxt2wAyeKH
         8Erw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        fh=nyXuiOhWMgpvOuFh6hbdJreQPpWwaqGyibD9+KEHss8=;
        b=YW81xrH6bCvF7TtphwY304SnRRilRU5u80t8pZpklJpnkGkFpHUa1WR7XJd7q6VnGv
         bm7jM8U1zQCn3ZiIJdLJRMY/uHaqTdtlzq5xPMNoDtoimcMKyKRZbOnYkQF5G07rMa0p
         JxdyJ60QW8ZBFTAm0sorNslokXI/GK/+bqn3suByi3UxqcvAbnJr9qh24f49wQyscz3e
         95D8OzIKwlQRVjpBq6xFtEwBeT/240tS1sDpGYCKt1klJAhAv8Xrpzg6XBfk4X/keQK9
         5VBGTl8KVKFHzMgOWfAevT0dblwJ16Rs6IEzQCNl0xKmYwi7IapkRbHs2AzXeOZMrf1e
         G7VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793928166; x=1794532966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=BXgsLCA51X5/W48GvZrpBezpY+stGa03fvEbUi2MV56MnNmF4a2PjDTUVnBg0Dwtqe
         Pc0pFbbkVSP0pF2lMOwQEWZuhIoVpWFLaZww3T/CDXUanEMozEFBbg5xukYGZHM3dK7Z
         /fQ7M+BmNkKN//ilq5bRiwTE5y+M3XE5NT96+Mb4FuQk23KwrKKCtl+UAKDpUXGzEGJV
         USSryhSewq0S2ePnFYtulTY16RPJSyBaU+5La6UtGtX/D/3Czi9oUOP9+hhoTJe/0ETl
         gYSYGkR59nTYA3bP+5Nf3SMG0P++deg+hHNjH+z7C7raNaTFT7WIIduRah7XGk96iqIB
         wcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793928166; x=1794532966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=zdECzwdtoDpJgyvIGsHn9e3DjuUdkKnWM0h1FwS+UxLXmLpAL8Smh9MsrG0Sp2AA2R
         mKkLJG5excRozlboI2+piO7lz0+Qk28TPE4P0WG/I0HxUW3eaSgdh4NSnDz4pQueNuoC
         KHSquZ6LT3kN4TMro/49Zmdhfkc9MeHuAZ2nnA6lqmsPh5lAYrHYuspN9eH8z1y4oYDr
         7+L+HS3rgbuaOOTKYIYkQd8akEJS4I65Q1wixeIoxRippVm0MEc4vPJtMVRh4aaFumIx
         U4zrLKnV8EeQj4FcYtxe63Xvg2oPj6dcasjBldG8wVfStc3IWtk3RR3n0hbYwlvvupyn
         b2ng==
X-Forwarded-Encrypted: i=1; AKwUvByFR/OW67XX7s0aG/zUWTdPqN5VS/VT55jqX3rs2JX8gShBKbsDqlBgw156/QcX96C7YCc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zmpU1uQAUOeF/o4oCkwGSnvw5rmEMIaiMaYnoYh735x9VsKzn
	QQbXlYAJMZ7N00m6B4mlKju56yN2V+PPXRsLyVL0w4y4XGWAizPmEEf8ZMp/9wmbH6v0une0CNI
	/8uyvRTvBrR/FOI3ZVvaheS3K1eNK6fNRixs9bRh0
X-Gm-Gg: AYBFou24LtTrzakUmc0sACcSEc4w38fISu1tAuI2TTh7Az8QvAqrr9MsVP2qRwr6On9
	od3kM6Y/H3yEO5YyU/1xcYqKo4bvYBJM14gMhZV6+yxwPtbZ3dsQDxdrX+dMnwParzPI/OBkId+
	Lvk48Ui0y/Re285gNUhUxEfOpgtUenq/0ekeK3jU0WrwP5quIg4NhXPsNMs1ORPyDTgFO/sIWK9
	7JiM7ITtoPOXo6+GPfdBjhqJCO5SXFQckh3CyP7P0sRtN24rcWivm6Wq6MDDTztRZjxdeH8Yt1P
	WiyhL4QqN5PrI24o6lVmWuADnqfp3/LT4ChA3RNTBFEXqmJfOG2feH3XEqWpOkRE7TdiHJ913no
	FjMjkxDbnjyPCyXeK6m60P4qvVJq6vjUqKXXOMJqPZfgz2qIxeKrtZ5sERyTn+S9mAPYN
X-Received: by 2002:a05:6a00:4f82:b0:87d:e8a0:2389 with SMTP id
 d2e1a72fcca58-8b37b37d233mr903874b3a.21.1793928166471; Thu, 05 Nov 2026
 17:22:46 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org> <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 20:22:34 -0500
X-Gm-Features: AclHuK_C6UmASiuiBuBvumlcrlzJEUCTa0-vZyEfxhlZIjAFaCskKj-ONE1360g
Message-ID: <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
> >
> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in t=
he
> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  security/apparmor/lsm.c           |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/ipe/hooks.c              |  2 +-
> >  security/selinux/hooks.c          | 14 +++++++-------
> >  4 files changed, 10 insertions(+), 10 deletions(-)
>
> Similar to the other patchset you just posted, is there any reason why
> individual subsystem maintainers can't pick these patches up, or is
> there some reason I'm missing and they need to go through a single
> tree?
>
> If they can go through multiple trees, can you split this patch up?
> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
> different groups/people.

Since there seems to be a desire to bypass normal procedure in favor
of speed (surely that will never backfire), the SELinux changes look
fine to me, but please do wait to hear from the AppArmor, IMA, and IPE
maintainers before merging this patch.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
