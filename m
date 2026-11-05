Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920680;
	b=Fq9HfZyWn4hNsV34rHRbjYfHJIazvyiK74RimldkWUcIJFgRfQFm2ks6TE8vP5TGaTty
	 ZkcitztRobvDWLuT05g9EJmmeSfmjniDK++Feqr9CZ4bjkrqXRvzh+VJJH2rOGj2bnCXf
	 o5RJT8KQtqJs0ixKM5znjo+LLJwGtgimSyHQmRDo8ujuam7cyBdL9OcSyjW2LbT+wy2va
	 Amltx7yuNetW6nRGp+gYlCHnZrHfVQvgSiXSwJfP7RLIOYyUm1xi5ISh/CLNIsefgEX4+
	 t773NpAXgcWI9Ycjy9oVYXJ7umUBcX94BsjmHKA9FiAYZ02O42tUoKLBlBS8Oc4OEsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
	b=PV+6bttcL723uHbV8/ldLOyTCOXUeE38MalX73g+yW/PQFn2uu09t/DGt6IR/lxjCQiH
	 ijYbMlpQo2Co9Z/oEO++QMUpLes84DQSwjwV+bHdzhxq/f4s+1wOgw83FpULJHrtXJzfE
	 KVqQRr7OkHd3RCD/zlNnnZTW/4DKZLLxiorRCU1sLE8XKB2Wiud9sAa8SgkeJNtKivWsH
	 RPY2uoB32mD6URxDiCG20xSySwuRik1DuZ0tW6N7fg4jqH2o+hTVCUAHH/9/nqs2tVm5q
	 mnA5D8GWZNABB22AKY5wE7WTfLffFCvf8VfsOZNi3WMR5izcQCN50LDlywoSjVBQdww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92F606A32D
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C92F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so30029a91.3
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920679; cv=none;
        d=google.com; s=arc-20260327;
        b=mMTbQs33sU3yQH0rwktY4z8jIprrld4D3gumPWe3V6uhUDqeXvn49K7213v15Ol1I9
         gUWdMztz3xodRbrvS8/S8DeGn8gCCdzm3gy2dLg/LsuskIfJ0fX864H/9F77s1+C1bEC
         SJ+KKLmhbqiB0CX5c2va7sCZsr0TMgahyn9PalBbs9pPdHAT+VkBfZy9CAMYo4kFSlEC
         /gUGK1uAVaI2EpUVPCLIwQkx5cZoZKjrfSebV/Igsm22CfS0B4F0fCMv539N3XXCnYY7
         nc2IxrYNw9HrRXilyC+WE8Jp5IB0ezAhn9JkRL1QsVK2x9eDjDmKSkpYHaPo/GW4j+/j
         7fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        fh=teLQPu/0Sgm1q/1uG0Ewu2INaOTNIfARCVX5e5Ip7xA=;
        b=ZZhJxEXlO5rlDLHpeNOZfrSQcma3aXwwGmVVfi5XaR3INCaXMZMcx3I110AOEUxnVr
         uGOaEU6xDaosKlhzdBY24f6B1nkEz7rmAu57JrCpqD8KsH+is5Lh5p3v2YDY3XRLn4zu
         T44R9e9rMPGagDSiPNQWww6s4/uYXugqqHms0RVeKxT9Y2fF5IuHZBquF/5vxz6Y+LCm
         QQzKyS1l5AIK7h/V5azl3kxRGfuKaAZTuehFPenvzxG/Wypd6YIniYS80m0Sj8AvCURA
         9d2V+XaxxMcTPYf7fcWxsFRWTzIc7hxfidvf9OFD4evjJa9BiWqFA+76FQNCR+53VjVe
         tH/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920679; x=1794525479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=F936vzKmZco1Rg9qiS2Cf7yXwnXt8dn1LQ3YxCN5SMsKSJRTlu37FG2JQnmiZ4tO3q
         ZY7C/eCqTECYbf79gAR8gp3oow9+Ykdrk78RZdAOFLnN4sIU8x8jDIiI/j4+tmIgfhgQ
         Kfc7/iulz45+20nMepsyi2DVKsca2I7vu/IOFa2DSNB+5NoNB+X3xZL+TnSEr5nUJW/0
         t+eWupnUof2Q+Z07m3XUdhgKdmPOk5SNXh4+R1i03zuB5eyYkN5hGGMTpwfL4P3jF/oi
         qjoVjwxKWuHtQbutc+EbzPaNTI2YVJHBnHBIs9egvV2qx2jXIUZICkPleteOCZKku3cJ
         ZAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920679; x=1794525479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=eCa40ZGsdSp70+P/6CHalCa64GqP5+jomk7cvUWDYK1lGz0HIsJ0E7w28ttPs85W4F
         IcV6oVbpRyyrsklqZA2dd09pvhJIuDNVqDk9GKZrZfg8MUdJtmyIYqg2pS0HWtPZQ5ze
         LaufTT5ftitTZJCOJIMsLOQaYL6RZzhP249X95rYIzi6J/k7Ai3tCeU8i6n0cmJmRMIf
         ZRuVTe1xt4ZCuT3n5D0W9dFFDJZxw8Fugrumnm/piQya6aKgdoz5ACledn+sginKWCzm
         BEkPHPosFMFleDuv5VgAY3NzSD3PntobXTFxr60VbMM02MGHjZoPptbTuIaIpaNta7bi
         kRMA==
X-Forwarded-Encrypted: i=1; AKwUvByhw3bjrez8zmibg613fLzh3xjEjtvqN/XQMer9of5uFjjE9nPi+tWc5D+S6QOSn158LGE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+emz3+/Hpbhnm/SfKUcSLdErYrd792pNvdVFYFLWsZb/5zDrCG
	g9DYHZ/Myr7SGm2j+k5QsCKkKp1+37e1zdm5sohjyiCYuys/DqLO+hA40wDQ3zPivpVxZLHm81A
	flC0VPCPa44cgAwg7UeGocDEtMyuUslqgFtyn+NJ7
X-Gm-Gg: AYBFou0ZPqvlMKy+wu+l1YHZ/F8gTsHGSa11MNHyE14XMzbG9nWmONBhVbfyBSHEp8h
	fch25nQhsMV/JqqDicvyUS2VPNdr2WLrVfZqnkjv+t/sAdzCZ9obbAbel9BsEO1JUCbK7weV4Xm
	DmpcUijMjZD8ZaMFLTge2Z1b9xxotFt9AufM/ei9Yi8nc/SiHeStA8nmlGt7cRg5A0FgiT2EpZf
	H5Q+i8NenAxRDq+phCBRl9vxe+UXr5js8PVqFu2oSdTbKA/fbi8HFBhUP2U8ndgxji6qFdq8toS
	Hz22Y+4RoAY/7TQF76jG6zOxwVbOrdf1aQDLCF4OdkIvjNUNAdECvO/7hKmL1n+94k4NFFNb957
	wo0rvJgFLYmKNqXpllBNw39Ff+BMJfqk1NQRuFKNp1Lino4H8NobfhaYbIP5tzUvlI1lp
X-Received: by 2002:a17:90b:1dcd:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3b0db703e39mr535625a91.34.1793920679319; Thu, 05 Nov 2026
 15:17:59 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:17:47 -0500
X-Gm-Features: AclHuK_gkg-Hspii6U5_01_jGLQO23B7F4YXuvzvsb53ImE19wnChR3DgLruv6g
Message-ID: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
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

On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/apparmor/lsm.c           |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  security/ipe/hooks.c              |  2 +-
>  security/selinux/hooks.c          | 14 +++++++-------
>  4 files changed, 10 insertions(+), 10 deletions(-)

Similar to the other patchset you just posted, is there any reason why
individual subsystem maintainers can't pick these patches up, or is
there some reason I'm missing and they need to go through a single
tree?

If they can go through multiple trees, can you split this patch up?
AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
different groups/people.

--=20
paul-moore.com
