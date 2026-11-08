Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794122438;
	b=J6cQz+3Vopbg4rd0kBcoU3CqI/ITjCSeSZKV17Sv6tWPpHkP0pnWrH2XPy2bQKwFJKt3
	 pzElj6cPDTSZOtO6ebSlBxoDZdEA/cap82qk8Hh6iyqyrZW0TMRR0Um17EZwBA3A8L0Z0
	 1+drhN/2ViSJ8Tuag2QEfCyGWiO0BEl7xyRdfB9RtSjYJ7A07TEckkM8SeamRGfzV0rF7
	 ywkqNqsWxJ2d14JAop5pbxmCUQra9lh5n8RDk53BeuoCFarwIC5hlFvX0nt92n1ae0kx7
	 l+D/ZlqrBFH5un19CAXZZ8wlnLLW2o+e0er73EVxNA7dXYEm86Xhg3w5YEBzKlhjUXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122438;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j18geaHLD1uUk2z5k4sfYhqgD5g0IHFNcch65ifUnps=;
	b=Ph2srwE6x9NQbPg9rc+3VbRpF8IdZP1KkgL24ApWgqWl4M1vkxbzmeVLMFGW165UZIdh
	 rPAr6qp96mn07+mi9ARkPIyRDhTVAT1rz4dyNK1QbzIlthjCL4FMDDoKbrPQXMauMP3QZ
	 5ZraGlgvOns82IZsbsHZWt4EpttWJvPvW65npfsWILx+R37W7X1BPiziKM/cpfTCLtsZP
	 DlvSjj+CpqDJ9q7R2EgiC2WYQrXPuFTSz0ELygTGj0QIck29+5orTgrGBdqjTbnaop6Vt
	 DNkTADh93qVXh4dc0rugszjpb8TCYWM5bcxaO0LE/AR1fENmkDAvpulk/dJpZuqglXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMR8+wvI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38CF606D801
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMR8+wvI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEB71F0092A
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 07:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122437;
	bh=j18geaHLD1uUk2z5k4sfYhqgD5g0IHFNcch65ifUnps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nMR8+wvIKadhl0gb53COwD17VOLLA+rRcE4ZHBalTQd6dTblfN0N7okKJf7t+ZvYG
	 i+1EPKK9teEdkZdwO91Euok2YuPx3bDEEyJZACadzh7IHZcjF1vei7j5i14ZyLr5ep
	 VqIN9h39OurgetTUjWptuiHXXMyNj/ch3S+eFhG/T0fsNkyWJuX0YGPBQx6Lgex5/S
	 FNRmmJykqrmIWyWTVXn405JXlsSS3qO9xBCUjnrmQGUYVaIl/HxcUmN8F/6FuB7OFc
	 JL6U/ckBGoY/1PGMAYkrv+aSutNpdVyFBUeh4a+QlDevhJINYdHgtDXtuUo8725mbT
	 sRhxrhcIRQeDA==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e64d52949so20307885a.1
        for <kvm@vger.kernel.org>; Sat, 07 Nov 2026 23:20:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHWByDGP4v+FnfZKANPxZKUIxwrKdyjW8MhvZY9k1O+bOhFmyVJtqpkXnRCWMCABDqiQH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8dkyp/ov5E5fr6J7Eabl87U1N/DxSvPFcrQTy5gSaZ06prD1F
	l9feLGTJCJfkA5c1uAf+3IcrcBBhV/ewaLNpBr7c/6WRI1dIv5Ewatzl+U0ydPUo6grLhuppu5W
	liAiq9G7vFfdiUniIyjKOOpdUXHM7hSs=
X-Received: by 2002:a05:620a:6190:b0:945:d7a2:4b58 with SMTP id
 af79cd13be357-9478427d0f5mr101426485a.65.1794122436125; Sat, 07 Nov 2026
 23:20:36 -0800 (PST)
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
 <20261105-late-2026-vma-flags-v1-2-0d3cd15ab75f@kernel.org>
 <sashiko-outbox-200257@kernel.org> <au2_PPpdAMgRJZtX@gremlin>
In-Reply-To: <au2_PPpdAMgRJZtX@gremlin>
From: Barry Song <baohua@kernel.org>
Date: Sun, 8 Nov 2026 15:20:25 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yWQom=cG5vw2B-FR8+7wNU+rwZkvghjAxusym+3OH96A@mail.gmail.com>
X-Gm-Features: AclHuK82gk7ruViNEj2rccGK1fXvxCJcs3PhbZ9Er7PSONJ4wRSmOw3bXHmiVAU
Message-ID: <CAGsJ_4yWQom=cG5vw2B-FR8+7wNU+rwZkvghjAxusym+3OH96A@mail.gmail.com>
Subject: Re: [PATCH 02/13] mm/filemap: convert fault and readahead logic to
 use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
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
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:53=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
[...]
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2=
026-vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D2
>
> It seems these are valid, oops!
>
> Andrew suggested a fix off-list, and I agreed to this as an in-place fixu=
p to
> avoid respin.
>
> I have also updated the series locally to reflect this change:

Seems like a reasonable fix. maybe_unlock_mmap_for_io()
could have released mmap_lock, leaving the VMA
unprotected. but  ra->size *=3D 2 is still going there no matter
if the vma has disappeared

For the original patch combined with the fix,

Reviewed-by: Barry Song <baohua@kernel.org>

>
> ----8<----
>  mm/filemap.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/mm/filemap.c~mm-filemap-convert-fault-and-readahead-logic-to-use-vm=
a_flags_t-fix
> +++ a/mm/filemap.c
> @@ -3410,6 +3410,7 @@ static struct file *do_sync_mmap_readahe
>
>         if (force_thp_readahead) {
>                 unsigned long folio_nr_pages =3D 1UL << thp_order;
> +               const bool random_read =3D vma_test(vma, VMA_RAND_READ_BI=
T);
>
>                 fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
>                 ractl._index &=3D ~(folio_nr_pages - 1);
> @@ -3418,7 +3419,7 @@ static struct file *do_sync_mmap_readahe
>                  * Fetch two folios so we get the chance to actually
>                  * readahead, unless we've been told not to.
>                  */
> -               if (!vma_test(vma, VMA_RAND_READ_BIT))
> +               if (!random_read)
>                         ra->size *=3D 2;
>                 ra->async_size =3D folio_nr_pages;
>                 ra->order =3D thp_order;
> @@ -3438,7 +3439,6 @@ static struct file *do_sync_mmap_readahe
>                  * pad that might exist between sections, which would be =
a waste
>                  * of memory.
>                  */
> -               struct vm_area_struct *vma =3D vmf->vma;
>                 const unsigned long start =3D vma_start_pgoff(vma);
>                 const unsigned long end =3D vma_end_pgoff(vma);
>                 unsigned long ra_end;
> _
>

Thanks,
Barry
