Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950957;
	b=eD5r1cfxKr8KMJjO0xOkrPqnknfIa46fKhs3OwMzWm5fxbx0pZKVOTpLTidYXR83k2nF
	 OzzQjoj1EH0DrOUGEjTvBj6jSxtkMJc3vtTB8CmEBosFjRYj0CZf4dFqU5hgsdlgVmnf6
	 mHhS0EGyPRW/mQ7uCnAmzZVhiSuLM8g4k1O2TkiwrhHI6grtGRu2cvXbwvSv+6dgGgRck
	 C50UxTHEaikoa0CY2pfEap9ATRPRHhJoBsLkL65iJSE2XyP1iVluZZ0KVXTsEOw7WhXuZ
	 6MnPxYm9rvkB9LLOpyAf8KA/l+TPC3weE15Srfepxx40Zv984rIv0lBYcEdehB9zLfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=zWlQqUwi5cRUhimzfNf8t4SG6tEbfWvm0hnj+kSTHoM=;
	b=nuLnJG2ZdEEWFYZZWps0obWDiSJ8AFcOjpLrjkI+mqE8hiFwG7ffXiBZvx2/pE/WYEIy
	 QBH1c1M52ALG8dELLSuP5Nos6ZNHB/UK55Bs1BV5W+8NGmx+Ynrta07auLOaxIyP8wPxs
	 SCbgmQGnQL1BTx+RjFYafWMQMoQYY/+ohLCbr7BrBY/IakgiZ0ddJxkauhk2U726vtnFp
	 tpTETvC0D//o36UY0pObtS3ocrHu24ksutmq8LEjbhltWCypxanuvEa61O7r0TlWLXr58
	 x4xQKMMRgld/jcvGb9PyTLv/cVdv2nRPb7fKzRmDqRvujNp8HGHv5YKB1SWM+oknRlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HUCU3INR;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E2606A33A
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 981E2606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HUCU3INR
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso180187a12.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794950957; x=1795555757; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zWlQqUwi5cRUhimzfNf8t4SG6tEbfWvm0hnj+kSTHoM=;
        b=HUCU3INRxIAI+4WUx3TTwhnKFu5FpEfXccmNSVz/MqR3VAc+7aaG0q7nPHxFIyQNI9
         qAmxJ3BO82+/70j7DltLfOF2cfbCWyzXjT/PoLXJo1+TkiFpRx5uQsd0OYQ0B5ax4n4t
         EANqISDc9+42zM52/KYQdcGMJKHyPHIuHSv1kAMiTf5tAqbEUxv2Xu/yDp/myOWlQ6/m
         cVa32K0NG3DruooAXdjUV1JB3lIOyjdQoDWUMEChp+kpflnp8kcmtVIKCJ+eWijj+qPh
         BGoSji9qXdX+zNdHbMnfDgX5K3fx+iiMbVuCRQ8wHEujdjjtu3CzpkxDeLweSo97P80Y
         uy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950957; x=1795555757;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWlQqUwi5cRUhimzfNf8t4SG6tEbfWvm0hnj+kSTHoM=;
        b=AFaWgW4YKOBJeuLvLbxKnp2XC1pCksOZ98YWW4L2hHHiUGMMKhjaE5eY/oJ5W4heXO
         mlspmE7MhqNRXYAfbjO9a5tchb3E44FRiyDZfSagFats8TMN6qiy3E9H0g1Ve2phwPRY
         HLdcJtr9FdX2RnPHJqT1r5IMihqu5+6YTgBAob4EOFXmzTbonfgRnspLTj8LpbOI6yyJ
         3SCEAjyE39dGGTkAcpWkkqH13KyOw4JmjtxDRbc+RRTNw/+Cc045sZ/kNNNn2nZt9Ryh
         Q4Ezftk1etrnQ4hUVZ8hCnTfQOCu34c1UxgjBDRzzSuUNhN3t3WFRwvKxp0UTFsicTC/
         09pQ==
X-Forwarded-Encrypted: i=1; AL+hErGwqRrqWYwl2qL9BVH0Biaghr21MXfS+61IEV0CJI6ewanLCF8fweq5KATsMPcNltrdYXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qxdQlutT3dZpyyAK8HXj637A0FWBA7BKD6TaIKLCRZYYjTx/A
	+zzmGBTQ4whUZv0gesbRwa8lV7ewiXxEgoMRZ6AS8TRh4RAm+p5wx/kPTGqbA4QbyCw0mjhQ9w7
	PWEoIqentN4qb8ERPMBlxwQ==
X-Received: from pgjg20.prod.google.com ([2002:a05:6a02:8154:b0:cc7:52da:b682])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e81:b0:3ab:c80:936f with SMTP id 98e67ed59e1d1-3b3d07631c8mr575388a91.16.1794950956600;
 Tue, 17 Nov 2026 13:29:16 -0800 (PST)
Date: Tue, 17 Nov 2026 21:29:12 +0000
In-Reply-To: <20261117212913.3634487-1-jthoughton@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117212913.3634487-1-jthoughton@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261117212913.3634487-4-jthoughton@google.com>
Subject: [PATCH 3/4] KVM: Annotate concurrent accesses to dirty ring indices
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+55eaa971f4924b62c9a5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

A vCPU's dirty ring indices are accessed concurrently by two tasks: the
vCPU pushes entries and updates dirty_index, while KVM_RESET_DIRTY_RINGS
updates reset_index, and can run at any time (VMMs commonly reap the ring
from a separate thread while the vCPU is running).

Use WRITE_ONCE() to update reset_index, which the vCPU reads with
READ_ONCE() in kvm_dirty_ring_used(). KCSAN doesn't assume that a plain
read-modify-write is atomic, so it can report the increment as a data
race.

Use READ_ONCE() to read the other task's index in the kvm_dirty_ring_push
and kvm_dirty_ring_reset tracepoints, so that the compiler can't tear or
refetch the loads. The values are only used for tracing, but the
indices are part of the ring's concurrency design, so mark the reads the
same way as kvm_dirty_ring_used().

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/trace/events/kvm.h | 4 ++--
 virt/kvm/dirty_ring.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index 07013f88e655..477a9d3705ed 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -316,7 +316,7 @@ TRACE_EVENT(kvm_dirty_ring_push,
 	TP_fast_assign(
 		__entry->index          = ring->index;
 		__entry->dirty_index    = ring->dirty_index;
-		__entry->reset_index    = ring->reset_index;
+		__entry->reset_index    = READ_ONCE(ring->reset_index);
 		__entry->slot           = slot;
 		__entry->offset         = offset;
 	),
@@ -340,7 +340,7 @@ TRACE_EVENT(kvm_dirty_ring_reset,
 
 	TP_fast_assign(
 		__entry->index          = ring->index;
-		__entry->dirty_index    = ring->dirty_index;
+		__entry->dirty_index    = READ_ONCE(ring->dirty_index);
 		__entry->reset_index    = ring->reset_index;
 	),
 
diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index d0693ef6e479..cd52f136fdf8 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -156,7 +156,7 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring,
 		/* Update the flags to reflect that this GFN is reset */
 		kvm_dirty_gfn_set_invalid(entry);
 
-		ring->reset_index++;
+		WRITE_ONCE(ring->reset_index, ring->reset_index + 1);
 		(*nr_entries_reset)++;
 
 		if (mask) {
-- 
2.56.1.708.g77570a6a1d-goog

