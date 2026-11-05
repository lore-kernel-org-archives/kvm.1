Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836892;
	b=ba3bYrOoHznn1/sy59lnnhqvfTk5CQ7tZUrNDgd11W1COjZmcSMuQYPUGxTrtHoHdA9K
	 lFYnB1FdyRfiReiiVCAUbX1u2uyW8J6vGmRqnNKrqqtLaP38KFRPswGhfVlH5Jk9H0YL5
	 QGF2jQ9MVOt9ruK99+dcADtomgvJMluW/xeePjnGG1YokyN7iNvzYTkPqjs/4pfRO/aQ+
	 jSYZUVwK7jrmYWLiTtl/S6GJ7LtY/hzrSDhaD+xqWizqje2OfSyPYGpCdsueTRBG2HPo4
	 1/lhF/Se6wN9UnRFusZ5A6vrj/pAZwAcESTHa6pNhizHpZhPRYYAUcsY8xSlme1zOcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hGlni/PkXFRgUv3FYAkQMj09xDV4V+0dB2F/7CgF5lM=;
	b=e+sXfkq5pEWVVYFeW+6qAbJK+FpWecpIx317DV1E1R96VSlerSOWYbbnu0E8lkT4EnYm
	 vtQXuhRFCIrTPkMSPOviCEgvIRpEEg1b1xitRmcRwHGR93ALX1lPUhIkxNg+mAIMGvm1h
	 DywmXlL3lm0928hoiwx7586V8BbjIYI+p9Da2WhwivKJWaZm64RT+r4hMmTDjjqgyQpDX
	 nCdXtx2V0cBk/CJVpnYWnTgY5KjDdERE+Nrm7pXPQdPs2zJ9RuT5a7ebbB6+0oTLAQbk0
	 ep8uH+29vz8M0RvXY9XdHnpSRbl0wpGxWlPtrV0goA7qCFCdQ0Qq2Tb1svGsqKFmdnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Njc7EdeH;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E85606A33D
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 00:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E85606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Njc7EdeH
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e47347279so760346f8f.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 16:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793836890; x=1794441690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGlni/PkXFRgUv3FYAkQMj09xDV4V+0dB2F/7CgF5lM=;
        b=Njc7EdeH/z+Mjpke9wFGWjJH1YKrLeY8skbB16tvhHC2QtapMFEiojjEH0peZy/X9J
         jVxSY74GjdloYqAfsD6YHKfUOvZuz0qYSBI0Y/wcYLB2lUl5kNjAy3vpzkThobUG8dC3
         FKw5yPhQrwu/nt08JTPtHEWNVqA5W/cyhWzCFVJlJzawwHc3KpnfJFE/HjvUfC5VJn+6
         OZk+gca7Yk/jUqFzYTDpjyeVakUox1X1IDo5GJ669Xs5jFFW3EBPkAPo295Y5rLAOx4J
         LU1KeJ67jvt0d5/D12Whh4fIKtaIi6AwZnOOeJTQiJHLbZPjTYGjCCCCpV901MdYIpW2
         quDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836890; x=1794441690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGlni/PkXFRgUv3FYAkQMj09xDV4V+0dB2F/7CgF5lM=;
        b=d8v0rdJhrWt1lZeYMjt8iIyNKVhxO06qOeY+sZvgaB1LvMzxkgZjz6m0F9JloOhe9S
         1NiZoffQRujBkA/ist32AFQ91OCHm+/HV2595kkXgrr7v4Z7BSA5QIRMHTefzKUwY9X1
         804+t0PKiY7u+Pvcj/Y/L3xPpmSJ1od1rXaHRF6KnfTNwrBM+4JAdSdb9izllQopCK9w
         ORpzsR7dHPSSRuvmXsnFblgezkSPufykRfGf90lUUCjEHdnppAdmloI7RueKw7ou8buL
         R4ZRgQcp5wxBy1I4TH/8q0DfWFxK3ixQen9MdlPA6l2wdB15+0xsTZrB76dvn0j0P1R7
         P23w==
X-Forwarded-Encrypted: i=1; AKwUvBwsXQJLJ/eSmSRI0JcjUoe885i9oSx+YdZZXfvdzXUd0Dgvn6yP34EIdyzdLfNlTB0YgrE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+shjwtf52IAipb17bxWp8ZLALoVafPkP8edID/GGeP2HMhYaet
	ANLgdbyL3PdZzWniboJKXvGo24CvRsZXafvzyxmnx9WZBglhBgpRnflb
X-Gm-Gg: AYBFou2adiLZBrToCTt0cHXZ8L4oP6Wb00Avhq5/PojtcwlgtpNwJoH9184ueiiJpy9
	AC3tqtPn7Tm6RzZWxI1g39mSwco3wn7bdYg9VIaKREtL8Cg8RZOpTkTadCuw8AW3mL93GnH83El
	W4tW94Y0NcYiufuXwIQVNyo5dKG7NmBXuVB0iFiplJxCCpLHWhy5BLEwEJQmlzYaSEGTxP3UYve
	PIG+QA+abJgOkZg4AlHe9PeMEOl60XtketP5dIIzl/7v4fP8Rpw3w9a4DM3fLZm5mwswfs3cztu
	Zip4gvLBzZZk5v9FlF1+xGIyY+Emkktk7h1pNWkNam5sBJSdweBo95dufFClDEcg244lSRjYE7P
	qBCYLRxzbq2HOD9HqWw72NQ0uqJuFQ84l3+1oVf6gH2/h08+EfF0+vifmfQTELQtbcDIsQOJbZ3
	33m7oIWzkhNhNDVPj2fczyHs+6AJTlFvtaLJvGaTxH77q7M+xaPei3aFZpUTY+VMPAI7oflTESI
	0586fxvy0SAX8tsA4Y8QE0XH256dkFTr/VLQNIxmswE+Xnx748oL5ZFbR7jGouG/qPvOO2rq96G
	5JhyLe5EEn+aSY/szccBl3yk/teKI5mnialiiH9eNrY4izcVkwNi0oGiA5ADp59CZSAvPZBacHS
	qCRvGYhEnJZt8OAPm2wZf7TU09HgL6kfyuZ8xgvw55eKxWv7lBpkSHkcDXBTSmi7gJA==
X-Received: by 2002:a5d:59c3:0:b0:48e:3b48:6f1 with SMTP id ffacd0b85a97d-48e6e50b5e9mr38046334f8f.54.1793836890526;
        Wed, 04 Nov 2026 16:01:30 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed553116sm6323846f8f.42.2026.11.04.16.01.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 16:01:29 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Mushahid Hussain <hmushi@amazon.co.uk>,
	nh-open-source@amazon.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: Use kvzalloc() for memslot metadata that fits in a slab bucket
Date: Thu,  5 Nov 2026 00:01:27 +0000
Message-ID: <20261105000127.63664-3-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105000127.63664-1-griffoul@gmail.com>
References: <20261105000127.63664-1-griffoul@gmail.com>
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

From: Fred Griffoul <fgriffo@amazon.co.uk>

Use kvzalloc() instead of __vcalloc() for memslot metadata up to
KMALLOC_MAX_CACHE_SIZE, as vmalloc() rounds every allocation up to a
page, e.g. a memslot that spans a single page uses 8 KiB for 8 bytes of
lpage_info. The waste grows with the number of memslots and VMs.

Up to KMALLOC_MAX_CACHE_SIZE, kmalloc() serves the request from a slab
bucket that is never larger than the pages vmalloc() would use, and
above a page kvzalloc() falls back to vmalloc() if the slab allocation
fails. Above KMALLOC_MAX_CACHE_SIZE, kmalloc() rounds to a power-of-two
number of pages, so keep __vcalloc() there.

Free the metadata with kvfree(), which handles both kmalloc() and
vmalloc() memory.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/arr1VgGZmgUmY4hc@google.com/
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 virt/kvm/kvm_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ebdf9308d06c..1854e1b075c5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -943,12 +943,20 @@ static void kvm_destroy_pm_notifier(struct kvm *kvm)
 
 void *kvm_memslot_metadata_alloc(size_t n, size_t size)
 {
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+
+	if (bytes <= KMALLOC_MAX_CACHE_SIZE)
+		return kvzalloc(bytes, GFP_KERNEL_ACCOUNT);
+
 	return __vcalloc(n, size, GFP_KERNEL_ACCOUNT);
 }
 
 void kvm_memslot_metadata_free(void *p)
 {
-	vfree(p);
+	kvfree(p);
 }
 
 static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
-- 
2.47.3

