Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461790;
	b=HRjQ4qi/HsOwFqPNUl3Mowes1TmWpVAkdRm7O+Z0XIeQhDUzq7w5D9yYNlM2IeFo2qP5
	 rMAvo0sGxSKEl0L9qYUT4Q+t80E8tV+xxkl/yEZYhb6T6QmxC2n/+LGpY9JJbNo6/WfRS
	 TTNV8QSyeGmQqIzmE/HSV15Bf8Qv0gxXo0Jh0qK+3GVRm3+WduFphHH7uyHNG1dccxyNY
	 VMMIdPxAzZ9vGYXo2AAtlF9U4dCqMWxXqxEnpNpfGWn+TcVkBPT0srXzdKksGCt/JCcxp
	 QFp1V0H4P4cPAGXz0zOga4QP3ukUVK0/ck4S+hPjtQw7Q4iPNL8w5wKN+bmvgdFvHcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
	b=pvaeBjoCkpqOrx6rA6g6lM9EpxEJN/Awu4JULJbxh22pkPlAH2Xlp6TB4dNqtIftwuNn
	 83cm6sJMXPXLq3SmSN1gtDWsPdLhKxo9u3SaUgbT57ftbOFPf1+sdcfDkFvEsPBZYUwVI
	 rh8YD7xRrZmUS10OiapRPDmQCMVC7BlJZjZROZMgDAzVl/QSaHlYYSn+KuRVeno75mpx6
	 0sJ8HO9sI3DcqJ92xzNTim+TZsvBjZskSwvzL9cwq4wlsksmipL2xz3FqfyUZJK0DvYpo
	 b+0E0/834VCqkClOe6cBmRZhauykvwLkOmILhto9R7+7Jj4xQDqzqqey7UbP4FMnS2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzLeINlq;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E837606A33B
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 05:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E837606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzLeINlq
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e55db58cfso352339185a.1
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 21:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794461788; x=1795066588; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=EzLeINlqWKLSrVyAYeG69cub/PpkhXEpvLI85c2/Wn4DBrX36De6eOjOc825yh2/s8
         /BMocYYbFGCIGlSENImF1edskqevAV/Kuf1SeaFnM5vAAp8DG8IO1FgayCsUEWs73OHL
         1RmURtZJc9D4dd17Nf7TyLA18R4yata5cpiLNB4SZ3wXp+wb6mfksV9V6NYOJLevPnzx
         KS0lFdrtd+eUvcxCI5cIGAuAdA3+x/lK/g0n6XOLpuLtAwXE7FSdI5GYz16DwRhEZcI+
         e0xi/xTmcXSNKhZMTs2dmsnafffo4Jcsb0EhR1rdi49ZUTTTqLCosCyqFBij3UK+VNvA
         tckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461788; x=1795066588;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=u88AR9VZ4qRkb9i0qGzaH+qJA2VRaW2Z9u2HCj2iU+RbC4fbYebwL0ujLt1FqeyoL0
         un0G8HuGGeqMt1zcVSgW58KTFkMuYXKXbwAi3tnU57GtETfcHo/fMPfXqaisbBm+ySh6
         4GJBvfNs9sBjqF3ehF/EPijhLrLWuK6dzvU82Jua8+L9Pt+pUlgjOkBYxh8HTIfIDxo0
         rGZm90i8HyhKzGyN/weB2GcocLJJ/LXjmLgl85ZqLdewWDbmJFLqseR8UoRUfssA/N/r
         Yo+tguzTEZzdx6O2ChnyDPE4OH90eMNtOMRa7DXqgwxVVQ6I+pUEdhA3M09MqjzzE8wq
         WycA==
X-Forwarded-Encrypted: i=1; AL+hErF095R95kBXa8nMj+YMWXCGuZnGg2bY5tUgQpGTA1h9W6Q7pGEZyQENC3lrHunRUs8lOkw=@vger.kernel.org
X-Gm-Message-State: APuU4Z86UDnC48sUUy/qTo6cAL4W4uiwfA7dCQZZ/8kBvf+rA/Y8bJja
	EgeZpa3hsf/jpc+sGSNNdyANGpPyI4BUtBAD7KcKoC4nSAXcyzTgwI6lpWR47OTPPD4=
X-Gm-Gg: AYBFou2otsd6lAZkVM8xFJELofLeUAf1jSYK/QLGwUc/OXGQFNC4gsZVMxPY1o1KKY4
	pnvdUEVtPtoeW71bsg47vRboNi8kfRSu8i8Z0n2Xz8k1jFua3NNF4U0z8N7quSnU5VoLo4ixIDw
	CtEUMcqEQs3nLH78IFMzpvQJKxEygzrQdBmFk5Hu7zbyKcY3jgD/zyt2taXIMJc3Plz1JkHWIxY
	1hSU6un/lXEVACifa9xnKtRFKa1hFHm9I/v2CwfuZwonUFlkQc4mQxg+swANdSYUvMkuDKYOdDj
	IARxmnH3F7bpm3S/Xn694so/17LMlCGIT3epwJNTZRusiDukqBjR4oeXpEI/cr3Kd91SWKBMELu
	5I714zMktRmdtg3cHhqJNMmXEDlQhgH6jhWECpz103mo1hJE9sXTSBrrV9DPndu/43eMXPk1VN9
	S/8/GVj783KlMbHtyE2nL8ket26VYT59i27X86mh6yN9qvk9b17KQVV/psmKu561ZQ6vxPkwHI5
	/2K+t45yJcXouRHRxMwcBKlQUjUJVJwuBsx3TRu9mplcbSXk16UqZXStS0QH286PoO4KDV2CFbm
	wS1MvxY9rOcdg5n/3sru2J8j/4JCLHJKSShHnkF8GjFiJLRmZqYJfoQEAyk2yQDHNlc4VPkf1v/
	KpyQCIrI=
X-Received: by 2002:a05:620a:4481:b0:93c:c2c2:40eb with SMTP id af79cd13be357-947b0046fb4mr764496385a.66.1794461787830;
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e4fa312sm647786285a.0.2026.11.11.21.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use
 vma_flags_t
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
Date: Thu, 12 Nov 2026 00:36:24 -0500
Message-Id: <179446178440.482102.12362401790016415292.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-05 21:30 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> remaining straightforward VMA flag tests scattered throughout core mm, HMM
> (and its test module), DAMON and the OOM reaper.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

