Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051573;
	b=wFomghSnWoitEBtSnfLpEV+2BeemqsspYBFgsPfc/7xCoXwCrdxtPogpELH7W8PucOm9
	 NdaJ9GKww8V2jUcoDS3VqtK2zfpuQZCpmrxVxp1QlJnJrm/16RjUTLdQZZLj2dc3LaMzY
	 qYMnk3jqgymhL1ltlJnFT4IAIYhkpY/qpdvht/HFOt570zBY5b0vXOB5QtAVMYy6NqFHj
	 IFaGj8nFoI4K4yIekVTFBvcDOyIw0k2HfDSw/bCYGs74uV0sVlSBanAGVOT/ZD1dB2E/o
	 UzTIa5Ktio81VDhVLGHOGrLI0gyg5SjSNSQqIImzymRc1rRBPciY1UekVylTRKZR6mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=OQEJn1r6phHG9JJTEKXNjl8UbrwqhLU2o1gcr6ks6C0=;
	b=ipycD8rnA6hBYfk3bJf0pRNuF5YRBwSap8B7yYeqRT0BUhmsv5wVMScjRbS0DbMDT02x
	 PviN+PiH/pjIZANTHKyIm5T2y36z7OfOGRPtA5yzIzaXVVblHVe6peYqAtupsidqc18de
	 +0Bv4JI4eESMkq8IWs3A7Jo66iW4rV35rst2qkHTSH4bCPWfnE5vG2Qgc6xbM4BLt5T3h
	 ZSkIqpxyg4GNoctasGkR36eofkECBSroPzVPsCj564URxfbZdiqLCH6qMJP+YnCtpZO0w
	 lqZ+aSFmcUL+sUY1MmTIKnGonBD0vX3u5HxX5B89wtcTTI5DWjJIrryi/9ltia4nysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ApDjmBZ2;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5960A382C
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 21:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED5960A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ApDjmBZ2
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab27eb38d6so3293438a91.2
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 14:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793051572; x=1793656372; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQEJn1r6phHG9JJTEKXNjl8UbrwqhLU2o1gcr6ks6C0=;
        b=ApDjmBZ2P5IY9M07VtIw4q1PCPK6CpIgTYTWQMTnhd4WbvnSeK4y3f8atnn7QA9cjB
         pATuIJVRmfxmUb6DVTcY2TSWeqihjk7sAkqWl2p7EJ+Outh4lOM6tfOP5bdm3xMdvvxm
         Gz5j1WDaxuKn1Qo4ZRLEMmGLuAM8u+S9GjSAdvAH/B5Z9aOkw665P34Qp/haslR+DdAh
         6Cf+TsLq3VxdxXfhvV5luqaTWzWAuM2gDcXBE0x9iCsw+vaQTyRrV4cFglmiecBVNbcN
         5aCJa8Oo3N1GkKfrvyeHtHj7KXN2+Rosy5Vsb+br/0l+WNOkW/XGL3x3Tqqyd1sNMI9t
         cLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051572; x=1793656372;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQEJn1r6phHG9JJTEKXNjl8UbrwqhLU2o1gcr6ks6C0=;
        b=bFclf7+VwPP6SDuzLVUpoS+0BHMfwvbJG5inWhGZQmuUJ89oWPBTUsiIpgPHYh82E3
         OtOzRfkeKQMnpNx6uC2Kp+mSl+GAk0bElKjPZ4vyFSVgikEAQNQKKPfrpQRkViCmqJQ3
         WCMA9UswhcR141tBsGiyniIBdUHpAS/TUJzz6JVwXx6/JjCc7mG5S3n1usCV6rB1asJ1
         C1BLs5GfP5UwI4/3Jv45vSRGWd2Qkn3RihQw2lDjLWsSgtSWzhyQe7lO1QoXPoD8G73s
         5ZJN0VX3n9c1J6G//RP0Yk+Wf2ueBkuU56OYrwc2rq0e9AL6TyXkURb6PbYMEoh5xAFy
         y4bQ==
X-Forwarded-Encrypted: i=1; AKwUvBylm+VwIHAOW70OSRWpnir8/2OlNgxrGyQsE8291FO37r6+0uAzl8/G7lYUZ1WU+CmhgQk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcdYYxE+FiiA040iAcxGkztGmRgTkD+DDWayxiM9aS77yBTjOE
	cCYpAlWxGp+4c5FsqPesSbMiadc8fvV2+rMrjC72X20oDWPt8htEw7pTGiPX1j0+ZbUrv58NPGi
	ic7JfyIbzWr8H7CPttU8swA==
X-Received: from pjbee5.prod.google.com ([2002:a17:90a:fc45:b0:3ad:f864:f94f])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d8c:b0:3ac:a521:95e with SMTP id 98e67ed59e1d1-3adead4f7ebmr6876350a91.47.1793051572060;
 Mon, 26 Oct 2026 14:52:52 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:52:21 +0000
In-Reply-To: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026215226.3713941-6-jthoughton@google.com>
Subject: [RFC PATCH 05/10] perf/core: Don't unwind the user stack without an mm
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

get_perf_callchain() only checks is_user_task(current) when the regs it
is given aren't user mode regs. However, BPF's bpf_get_task_stack() (and
bpf_get_task_stack_sleepable()) pass task_pt_regs(current) when called on
the current task, which are user mode regs for a user task, even if that
task has already gone through exit_mm(), e.g. when called from a program
attached to exit_files() or to the dying task's final sched_switch.

perf_callchain_user() then unwinds the user stack without an mm. That
access does not reliably fail: the user half of the address space
belongs to whatever mm happens to be lazily loaded, if any, so the
unwinder may read another task's memory. This affects e.g. arm64,
riscv, loongarch and csky, whose perf_callchain_user() doesn't check
current->mm itself. perf events themselves are not affected, as
perf_callchain() already clears the user callchain request when
current is not a user task with an mm.

Check is_user_task(current) regardless of the regs' mode.

Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
Signed-off-by: James Houghton <jthoughton@google.com>
---
 kernel/events/callchain.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 9d24b6e0c91f..a451ca2a5573 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -245,11 +245,15 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	}
 
 	if (user && !crosstask) {
-		if (!user_mode(regs)) {
-			if (!is_user_task(current))
-				goto exit_put;
+		/*
+		 * Even if @regs are user mode regs, e.g. task_pt_regs(current)
+		 * passed in by bpf_get_task_stack(), current may already have
+		 * gone through exit_mm().
+		 */
+		if (!is_user_task(current))
+			goto exit_put;
+		if (!user_mode(regs))
 			regs = task_pt_regs(current);
-		}
 
 		if (defer_cookie) {
 			/*
-- 
2.56.0.307.g5fe7bd680c-goog

