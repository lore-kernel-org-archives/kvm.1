Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447991;
	b=JClTBDwgZPUnMxs/oPNW0A311Xoqqq7S4CVO+Mw10kBKfOfEpKMDD+JGUBcV3idqhaq6
	 bODlUhgnz/j9A4afIlgh7yE784uVw8PwojhdpOunI4kkPck/NtpZhVBVRoOtZtARn9TW5
	 I67fSUPIJxaCHZj0g1DDow1qpDpqGA81s3V96OVtMB96vdtRtI/8x+/DrtTxsbjqctgyA
	 o5WjQDAhaZLhSou5C9HTcVKJc+13GhNETAZ4NEpVkZK6HDdiYNmCuSpz4y6YhxDMM1AE8
	 BjBSoncEkFO95KPrVBET+Kf9EmeZzeLcyu/2EdAsRCUzdF7ad70eUKt656aifplJsMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Om3+ZF0XtREIm6HCfdv7ugOGpXmbs7kvx8h4qtcjszM=;
	b=oTtwE13RrUzhPc0eGJhSu0zifaEQ6RP3EBcq0CS7+vJiaTbzbPdDEd0Rf7ZkAfmftTOt
	 UlUDlTCvWMRZuS/mhOpplSTmgYPnZAysHLQ1hkKo0PUEgHnEtqPJnvh2CbWO90vKhICC0
	 MUlE2DmlHhNzXElDwYhRnmF8zMDZ5cnGTdGMpKPVrvVGEIi7Pk9JL/WmtMF1XOefDeapu
	 BTJ1VYTZHw3y+uRqYzDIrRhvwVAZlhzo3CRzmCZQ+h3k75l0w8N9H83U6w0SAlSsHK7Wq
	 B05AuHBQRRi3nXZpC3op6AnSvJKB+09Eop+/FdUTKC3flM3j/L7mAphrm05a+q4ddIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=PDpaJYuZ;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA3606A686
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CCA3606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=PDpaJYuZ
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38587f3de36so4146459eec.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1795447989; x=1796052789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Om3+ZF0XtREIm6HCfdv7ugOGpXmbs7kvx8h4qtcjszM=;
        b=PDpaJYuZb+DORPk4kwRe6ZpuRcQHMCKRWIbtR2XvtYy7GdBAgIH2GezVfCd2rGjJ/m
         5rT5z5RSWLl+ftMa7vlJPFotH8mJMWu2CrcEm5RMDRWU8d2bkS+Z3C/phqgJUa9eWb2u
         vRZOgjAG6HY0Xg+nGeLndPrxNDTdJNzCO1jsRN/vPHvTTilRiRPPmku299ZIt+FF22Bd
         4abR9gbzYe4ZB04LCtHIb+foAkU33R8OGQJJIpvfjuM3CDKzXR0fSQh6EeOtL7Hd4L53
         VvQl9Ol7LHDS12NQB5k2i9m531Q4Z8bTahV/i+OEi1Rtd2o3zIiMS65VwcYGnbPMARGb
         juDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447989; x=1796052789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Om3+ZF0XtREIm6HCfdv7ugOGpXmbs7kvx8h4qtcjszM=;
        b=HIWhsjbpgMPHJPWKvkU8BqNkPs91HCn6LLnW1u79hxkCQgMCqlkMGvaA+XxeDtkrk3
         SLAuwCKkKtEe5a3VODrzDeiLE27YdIg1fAFNNHQlFU6CAsVl+P3duHmodnlorqL6WNLs
         mrmFJ7PR2amcqkY/v2Bban0MW8tdm4h5oYnG0IHEscw9pcKrFFQwjQfiRgvEg+8rnKzB
         FY2c5xFSrOCO7ypDGhPbqmMK4tEJkCTe0MRbzl7hdbYUmRCIjd4K7IHN/pc+7lIfepk7
         HM7K0RbmxAQOE9WATrYx7AEXNzyAU6V6N+iOUb11mmwtmtRL8gThcnMIclCM9swTzDiQ
         WJfg==
X-Forwarded-Encrypted: i=1; AL+hErHgkZPh+Hs2P2F0af8ZGcqQ1WiYzmdPBj++du2h7c37bo/OQZvN3LkfNLIivXvFyqScLxs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rLpmNK6lhfQHlz2VhkrvtwXPhli0MnvDArg24nmh53fkORvVh
	yJwqcWSh7pDuapqix5nePPu4XptRIHk4FYm0Ho8X5gV1eG6lfGauoIFh2raRj+i0Erv/rcb+Gho
	pUzNkpg==
X-Gm-Gg: AZFdTZfEo9v74s3vWK6yNdVTkMQ3Hyc5UtMsfBKGVtVoi7RbdNv0N1kGAxNWTduBADT
	qgfVsi0LnwRgyTymhCVfWM6zAJSOUkMqOdmPn+WbpZv6BSCdZfgGQr/fr6VMnAtDL2ulKc30dgT
	4niJjbj4cJYEaUZwurIdyHv5kmrKHecCkcKXmCmURJC2GU8ZH5Po+Prr9Ms9rerrJFNSccjM3bu
	kerVkj8w8xEIPxpm4stQzUbdCapeUtEyTh4Wl33RtyuEX1bxWlGIWU5AGXDHd1CL9Js15CTJxpK
	QlygaZmC/XD0ltU0IuKt5M/7dSCAiFmUicZZJ/4r8BxU5DRIuxLKWPIYTehhODS6lDyuhMT08pi
	Cojx5uGFDhBj2+Fn6zR6fLmMGpdeJK7nG8u7+D8UDxqMXHOMwnq1+JwuA61UkeHt3xKO9d/Ohy3
	KuJIhVJWMKZV3499TogD0ksGNkzE4SXnS+D27HO4lXEdZMuiGdonpD/Cxc0CNk4rn1U76yNZoOZ
	c4/mDsN35iQvMoSfWiCXthBTx8POkUiEgcIa1JhsHdrVnSJSVNpEj51w6ZOAodV9OMOeEBWO6QU
	JsLFeARYFxppzRtEBVtcMph//fvqDa8gEW9fcVFPpA==
X-Received: by 2002:a05:693c:8947:20b0:386:9ef2:8e01 with SMTP id 5a478bee46e88-3869ef28fe2mr6486341eec.0.1795447989335;
        Mon, 23 Nov 2026 07:33:09 -0800 (PST)
Received: from localhost.localdomain ([2600:8800:1e00:25f0:3391:10c3:1717:1522])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm34601237eec.16.2026.11.23.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:33:09 -0800 (PST)
From: Siddharth Mishra <smish149@asu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	James Houghton <jthoughton@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Mishra <smish149@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] KVM: Disable preemption while pushing to the dirty ring
Date: Mon, 23 Nov 2026 08:32:37 -0700
Message-ID: <20261123153238.1036972-2-smish149@asu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123153238.1036972-1-smish149@asu.edu>
References: <20261123153238.1036972-1-smish149@asu.edu>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable preemption in kvm_dirty_ring_push() so that another push to the
same dirty ring cannot run in the middle of it.

kvm_dirty_ring_push() selects an entry with dirty_index, fills the entry,
and only then increments dirty_index, all with preemption enabled, e.g.
when vmx_flush_pml_buffer() pushes the logged GPAs on VM-Exit.  If the
vCPU task is preempted in that window, kvm_sched_out() calls
kvm_arch_vcpu_put() while kvm_running_vcpu still points at the vCPU, and
kvm_steal_time_set_preempted() or kvm_xen_runstate_set_preempted() marks
a page dirty, which pushes to the same ring.  That push fills the
selected entry and increments dirty_index, then the interrupted push
overwrites the entry and increments dirty_index again.  The entry after
it is never written, its flags stay zero, and the entries after that one
are dirty.

Userspace harvests the ring in order and stops at the first entry that
is not dirty, so it never harvests any later entry, and the GFN of the
overwritten push is lost.  A VMM that tracks dirty memory with the dirty
ring, e.g. for live migration or to restore a snapshot, then misses every
page that the vCPU dirties afterwards.

Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Mishra <smish149@asu.edu>
---
 virt/kvm/dirty_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 572b854edf74..1ed8b8771c3e 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -221,6 +221,8 @@ void kvm_dirty_ring_push(struct kvm_vcpu *vcpu, u32 slot, u64 offset)
 	struct kvm_dirty_ring *ring = &vcpu->dirty_ring;
 	struct kvm_dirty_gfn *entry;
 
+	guard(preempt)();
+
 	/* It should never get full */
 	WARN_ON_ONCE(kvm_dirty_ring_full(ring));
 
-- 
2.54.0

