Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051570;
	b=SarkXi6yRi7mdx7p9VYE0QxBMOTdoSxF7Pww3aIsIqBeBqHO03lhNAja9QHcgFO4cFE5
	 51H5IruXIUj/vymjJn14x3ZqSmnhjmHpX/BzrAnO4zKj6zdEx4fATe6gB28QIrwGy4Q8L
	 eoooC1V5X9FYnJc2z1eSdw3P+pmYCKxHQD0oj+lUcgn9amSOxwJvGmpSrixVN5UbxQuUb
	 8NvEeC6lVI50JWoYujJOoZrpabWryqcImFLk/D0YnfbCUngk/dcJLEesadYz4YVHS5q7l
	 +buHDCLG0L2/yOC/8AbbpbVrJA6K/seWomo1VBF/osiQ/CCL/nnlQvhn76z5/Ax8Mog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/8L34Uc9Xo1d4oJ1WUUvtNMd/yh9NNapi89sPDAfm6Y=;
	b=1fHCDVwecffXyFTYmiErSHriwOYNs5m1ZcB+lX9oYPP+WF2iwemh0Rn8lQa2C3e2njM4
	 iqUblvvT55JLnMtyI1QYNPksusCQPB6v/10U9eMOnYXi4A4wYoKQltbbV2hborFMynRLs
	 hFfyUhjNpg5Q+kfbvhtS+nK1FWR0lnr0uvYQpXZhmKTOmNJXU+027NATzACHHuwwYxNN1
	 qcFzfqC1VXsnZGhtZuIcHiJcqgQBmU2DfWP3s4e0uxT8jkDM2tLjCyMwBcp1mOcgrAz4S
	 6R9uituHFDbwno+96qbPm1KqR4njMGEv1e3CcJjOFn7nqfKdNz1vC7zh0AGJGuUli7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fU7gA7Dl;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B660A2615
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 21:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A9B660A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fU7gA7Dl
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd6969473a4so2053544a12.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793051570; x=1793656370; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8L34Uc9Xo1d4oJ1WUUvtNMd/yh9NNapi89sPDAfm6Y=;
        b=fU7gA7DljvCqdvdMpaU2dp8kIrEccZFKOmWnfW6sw+A054S6dlNZugZLhIYYcfiePQ
         hsLgQW99gw7/40gSfJI6nU0rtnm0+1dPDbRaUoY665tdkjNVHr2UFbegtIbotfU9v9/A
         uK7QOilz2oAfaWXl/tsF91D3vAUMVrFCU+UmdWgUF2++tfRICFcImVM7cH8b81croIe/
         3gbPbeDpIxRnPDaXaoU22kL/RynJy6L0hYZfzyDRTzTeCDcQlDb8FUzF1BEGuZLmjKzH
         eeONqBOhxrAFnMU8HI0VT7oOvpOxL8LajgaOKQMUvvRXhW0M5pmi7s9QGStFhbTf6Lb8
         9JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051570; x=1793656370;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8L34Uc9Xo1d4oJ1WUUvtNMd/yh9NNapi89sPDAfm6Y=;
        b=Q6I4YQsnLN/CPGU7GaSocA7YNfwZnEHmmUWY4S3+Kvd8q2+LnLpdhYzltTn1J6kWeH
         ovvyFahkVbhOSzo2kXh7L28LPGAwXcCmTJc1Cm/D+GuK06ZHJkq0+4wKDrUncroa2JjB
         gqICZcNFR9BP8LSbaSY+0x3/yl67tZSDMrLFS3b35W6bWOJfJCYXt5/RTqYkclI1Mjms
         jW6ySSJ6yl5IAHbfRIefzxAxkXYJuprGtTMTmAsOoL5MntHdU+LjUcXxy/qF6cDoprt6
         jwxDZxopmo5Fs9K/UEQuHHJ+1p6HVf7KKZ236mz8Ge3kBInr04utdjt01YS6YLDywNAf
         M4Sw==
X-Forwarded-Encrypted: i=1; AKwUvBz1mvnEZ9dRzYPdJWz0yfp+6NpLhw6ZlNPh7kxYM51RFurDKl+q2oaS/ZWsb0lbPYImVGk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEtgUjvJjA2PxwCEns08CbABjcU1FIl6VrJ+VsxsVnZZJcoma+
	ZivG00QYwmqgGDQR59PB4BmjWjEobeL94n399+qvq5KW58ogmMZWWZC7qrNIwes3kH1i4aIA5TH
	VoBz1prisH5yuava+PuPhLA==
X-Received: from pjbme4.prod.google.com ([2002:a17:90b:17c4:b0:3ae:349e:2bcd])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35cc:b0:3ad:1b31:92d8 with SMTP id 98e67ed59e1d1-3adeb16ecffmr5865801a91.60.1793051569572;
 Mon, 26 Oct 2026 14:52:49 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:52:18 +0000
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
Message-ID: <20261026215226.3713941-3-jthoughton@google.com>
Subject: [RFC PATCH 02/10] btrfs: Don't copy encoded read data to user memory
 when canceled
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

btrfs_uring_read_finished() copies the data of an io_uring encoded read
to the submitter's buffers with copy_page_to_iter(). It runs as io_uring
task work, but io_uring may also run it with tw.cancel set from other
contexts when the submitting task can't run it: from a kworker when the
submitting task has exited (io_tctx_fallback_work()), or from
io_cancel_local_task_work() when a DEFER_TASKRUN ring is torn down.

In a kworker, current->mm is NULL, and the copy does not reliably fail:
the user half of the address space belongs to whatever mm happens to be
lazily loaded, if any, so the data may be written into an unrelated
process.

Don't copy the data when the task work is canceled, and complete the
command with -ECANCELED.

Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/btrfs/ioctl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f3e2afe221be..d9044fbd9547 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4609,6 +4609,16 @@ static void btrfs_uring_read_finished(struct io_tw_req tw_req, io_tw_token_t tw)
 		goto out;
 	}
 
+	/*
+	 * If the request is being canceled, e.g. because the submitting task
+	 * has exited, this may run from a kworker or in a different task, so
+	 * don't copy the data to the submitter's buffers.
+	 */
+	if (unlikely(tw.cancel)) {
+		ret = -ECANCELED;
+		goto out;
+	}
+
 	if (priv->compressed) {
 		index = 0;
 		page_offset = 0;
-- 
2.56.0.307.g5fe7bd680c-goog

