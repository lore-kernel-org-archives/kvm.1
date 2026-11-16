Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794799675;
	b=dBLYoI8m4No9wHJDuACJIcI7+T9FI5v44TsmiuAzj+qZMvIezjxPXR3qD9pBCLUEJ20z
	 8ThezaqUaVw7f1zNo65VqRjHO9yc6bXcoQIz+BVtpSZDGiH7n7hqOnA34fvpfMh3benUD
	 1fwLP8qjvCJ4nkoq+CdfJ4RNVHeSEUasfGl5+9f5p0RGtxYOElZZut5enEpm5Ewm57Q12
	 X+iZ5P2BAAcNPMtF9kDmZcZU/LG2Y6yAgUJ75wDCiYRzlScE1fsrMvOxu4UohfUsgPNZv
	 nKlGDX/UgqwDXrLIMVaJxayVWvCGbcWTXFf6OIJUmpIAgwYOc1edbZhcTGbRnXlQ66Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794799675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L5nXnVzpW/caqv+K/A2q7IBbs0VCM1fpQx93oMsAzA0=;
	b=KJDbtwLzoo6E7Z/Z+hNMVQFofdgDibV4gGpm/ivn53tEwz/7KN+7oRfc7SXDfFv/U+AH
	 yIfujBGtpsF2M8wKjQwJXlJ5p8oBo0CMQYoGxnu5WeXmYaA0aVQhJXvB3HD7Uc5JaAoI2
	 i9HP/DnM/kZQWvRNCvLo5npKK1Nu7FQVVyFYWaEBmIZ36KhcDAGuudZdAZxMUKb2QF3CC
	 XzirCrliyVLK4p4DSY8TGjX/J8z/v3cLEMGbrlvDYXGvvWQtY2tuY60l9SaVGRtQDql75
	 TQUKnAjaItjdLcSrHt5/uc9F0bvE8Z8RBT0Zg2YvG+kx1Iq31wkj1w39Yb+5P+k/yLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="r/QqhurX";
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EDF606A883
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 03:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35EDF606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r/QqhurX
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso1493674a91.2
        for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 19:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794799674; x=1795404474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L5nXnVzpW/caqv+K/A2q7IBbs0VCM1fpQx93oMsAzA0=;
        b=r/QqhurX7n5x3gb9cO8OuK5Wb9h2upvwBF2DI9E2gkH2rzxtjh+twQ3Dz1+oWDLB9S
         PapHbVFBbcy0XcO/V8PoUmhU7bsxXO/PHRjQLGmtWE/ePHAHIJa1brL9/bDmnv8JvM3Y
         rjhlE85Ccd/+mvkO8WeLO4iHCigV1Mckx/o/DzrIW0nBUoiVfbq1DXr8NlaWIn4kNN+D
         AGxTGY2i82wqjr5v5AGJNiAQeIfEVzfjkEELovU2PIGcLylZofbjzoCYHFHFbBRDurJx
         69qxMb77mQFNO2gx173fSjNc7Ih1Q6O0HK5W/jDHszk3JeQ8CW2WPJc97sCdOsHwtr+n
         hdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794799674; x=1795404474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5nXnVzpW/caqv+K/A2q7IBbs0VCM1fpQx93oMsAzA0=;
        b=bZXg48GSqX6fXacM3CF1uWZ8dPjtxbDuLfxR9g7TcEVfwRXksp9v9KGDgUvpouHiGI
         y7Ap/beFTUmHP7fv0g9OTwrusjUt1mKQkS8dm8kb31Ic0MI7SQT1U7g5DRDEK+4GW8lN
         eEn+9wOsyYcbqnlY1Q2PeL0mk5a7f0D73/R432CnnXZLjv8fRGuFsZCHIyLGN559x5mi
         qfAaEQHpswd60uOdkWht8scDyV91yACOH+Ej9ANA705mHazKlMPzE7rbhMnZTJAuXbOo
         ZpcIQOyXAqDaGmAJgBVw2tDoCsYZ/+GkVST2ay8Jaa+uJaA6S89dg20eFIektE6xI+Sj
         /NNg==
X-Gm-Message-State: APuU4Z/j60oSnWony4Z+Tj/aEnZmNFxaEnhQzXkm5DIjmkHSPFpEXwfM
	L/vW7S03kN0pZtlF3T1c5wsz8i66t29n+dO7ExsWSCO2JSXodj1pri4OHGTC3Q==
X-Gm-Gg: AYBFou3qZj5VcAEqBvLJ/V/Fq4Q1k2bo3NDYrGYwVQcxD7x/IWd06SvxoTghhFPqIn1
	1sGPzGAzlimP9ZvTLq5NLDzpmp4UdyF4/ys10GQOF+mb46aw+KD1Uw2GME8vhMAewDVbuXYtEVk
	fYtYh0Tg9pVtmf95yjRj/zCintl7xBsbKvb19+MteQVDx7rPQoKai7aGZAqKFhztYfKJXN+re2K
	TEjsJIC92JHE/yzEc2+h0lXzW6QGlTMr6dtVfvj1M7y6dhLh3xN7jhDWvaH9ipRJl9yHVoXL15u
	bwyB+MAFgFH/PRpQtgRDoX5dAcQwMUgXWwg//lkUE+OrkCfLSYBZgC9X/5KLdjUBJ+153dJc8G8
	9sOeglNh2UXdt9RZn9zOlXGSnmgeoetfWVNqWsSFPeqBbd7fnWrn40KPn7P5Hmvfzu52qx59Mla
	oEY0YTVkAePaOy39Q9wSXGiyWHXCK+lPB1mrk2tLP7cXgtQKxP0JQS/qyQ+y4FhkP+T/W9aPZmb
	0Ovx3icmpxNDhnvlu/2lki8YByOZvcsX4nCXL4cq6h2RHJO8S8N8VEaNQLiiDOPzLAv+zk2U6s0
	kAR8suW1uBtFf399yXKIqmt0I6z2P1fjvR2kdqGy8W2TC/WQj5bZXyyM6CNVaE3EO7oExbWqxQ=
	=
X-Received: by 2002:a17:90b:4b84:b0:3ac:ad90:7090 with SMTP id 98e67ed59e1d1-3b1b0ccf3b1mr9726976a91.67.1794799674494;
        Sun, 15 Nov 2026 19:27:54 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d32ea0sm18998570a91.15.2026.11.15.19.27.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 19:27:54 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH 1/3] KVM: Add the halt-polling time to the kvm_vcpu_wakeup tracepoint
Date: Mon, 16 Nov 2026 11:27:46 +0800
Message-ID: <20261116032748.54582-2-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20261116032748.54582-1-flyingpeng@tencent.com>
References: <20261116032748.54582-1-flyingpeng@tencent.com>
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

kvm_vcpu_wakeup only reports the total halt time, which includes both the
time spent halt-polling and the time spent blocking.  Report the
halt-polling time as well, so that the split between polling and waiting
can be derived from the tracepoint, e.g. to build histograms equivalent to
the halt_poll_success_hist, halt_poll_fail_hist and halt_wait_hist stats
with BPF.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 include/trace/events/kvm.h | 16 +++++++++-------
 virt/kvm/kvm_main.c        |  3 ++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index 07013f88e655..d03e3954ca37 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -47,24 +47,26 @@ TRACE_EVENT(kvm_userspace_exit,
 );
 
 TRACE_EVENT(kvm_vcpu_wakeup,
-	    TP_PROTO(__u64 ns, bool waited, bool valid),
-	    TP_ARGS(ns, waited, valid),
+	    TP_PROTO(__u64 ns, __u64 poll_ns, bool waited, bool valid),
+	    TP_ARGS(ns, poll_ns, waited, valid),
 
 	TP_STRUCT__entry(
-		__field(	__u64,		ns		)
-		__field(	bool,		waited		)
-		__field(	bool,		valid		)
+		__field(__u64, ns)
+		__field(__u64, poll_ns)
+		__field(bool, waited)
+		__field(bool, valid)
 	),
 
 	TP_fast_assign(
 		__entry->ns		= ns;
+		__entry->poll_ns	= poll_ns;
 		__entry->waited		= waited;
 		__entry->valid		= valid;
 	),
 
-	TP_printk("%s time %lld ns, polling %s",
+	TP_printk("%s time %lld ns (poll %lld ns), polling %s",
 		  __entry->waited ? "wait" : "poll",
-		  __entry->ns,
+		  __entry->ns, __entry->poll_ns,
 		  __entry->valid ? "valid" : "invalid")
 );
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..fff19e9239d2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3888,7 +3888,8 @@ void kvm_vcpu_halt(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	trace_kvm_vcpu_wakeup(halt_ns, waited, vcpu_valid_wakeup(vcpu));
+	trace_kvm_vcpu_wakeup(halt_ns, ktime_to_ns(ktime_sub(poll_end, start)),
+			      waited, vcpu_valid_wakeup(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_halt);
 
-- 
2.43.7

