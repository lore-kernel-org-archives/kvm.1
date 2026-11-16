Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817883;
	b=jdvXezhFGaVK6yOzCoTEnZ8ua9DyK7M4FNtJIvsnrWYKbnSO93DomFOb1zkymCLS1vrL
	 kWlII4HB2GL+0fEU7vBRDkN1BYXU7Zleb9vKDrnd+gDx0H+q1kJRiliUZXaNZoRVCk+EI
	 OTCQvQhncs2Wi+ALBITFRJqMuhqywenb/WdhxJPEpGmiBv9jrmngj//MkgeFDrhkdgAxA
	 Y1pSFT4CCLuu3Uo9LFlow/9f9pokntNRANdlzFArTHbUOl92KIRxr+5DUxKvQlJ5uTOGL
	 O2bMcfOBzb4ZXIQ+9ENU8CUWMPRUxcl1mwZ3+Q3395B5gopZDi182o5CbEqD3fOon+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L5nXnVzpW/caqv+K/A2q7IBbs0VCM1fpQx93oMsAzA0=;
	b=SK9BUQD6nwkJ1IDaktZ/XAPKnF08+94K6pbd9u+kNYu6APDqLU6XCk24pnqwdy2ogNBt
	 kTpuo+isGavMKt3MubIeHITEOhw6ebCjlPdQTh7HMPjV/N5DJEIFr+5NFwZU+eWjB23jo
	 W3EbOhYlIrE2oKy5pZpRRS/iRKfUCG/Jl7aJPxlWyrG/Jd3fEI0+dmOOTgdhH+8H+QFVw
	 vWjQcz4/tK87Bx1fvtu1aWkDiUqAC/lOHNWYwxlW6b9HF++XKBKwggLwP8z/Q8FJF5vXX
	 jiInUMKZYtU3Nz9i9wv2FaGgvis9rx0l6nzrDGFM0WOsnuGI05KK6r+M6cTqhKT+6ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAUVSycd;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B43606A333
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 08:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B43606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAUVSycd
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so2774877b3a.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 00:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794817883; x=1795422683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L5nXnVzpW/caqv+K/A2q7IBbs0VCM1fpQx93oMsAzA0=;
        b=pAUVSycdGIKmE4UIRAx9tGoYiDtqoHJmraU30qUd6i6na88KKxqubOKERFYhCFnkai
         wsDyowlvcXfJTC55U/p13qrefAmZ2oQ6qqzDE5hXhF3suDfm8AbNgZqnxqLCcisWOh0B
         D32trAAiQtM78fdhKQkdKqehUS2UdUqvB1/gXA2Bif5QnYHRw6L1ozwERSV89Rc/DD6+
         DDLSFA9SXOOHgxBMM3WK2jbxBeuYElrsC3+y+ODWAK57/uZUDjpqq3eHsE/y0OO+ytfA
         XeoRaxxbmvcxZyCeCiN8LUOSGclKUKmlv9zMFiCAE21DDyXhcrgAVly6A9SKyJ2aQOJw
         /fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794817883; x=1795422683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5nXnVzpW/caqv+K/A2q7IBbs0VCM1fpQx93oMsAzA0=;
        b=uGtFjGrBu1VvmrhS1xnpSYS9Wv8IQaxn6NP8gAUIoM/CrRJ6u19zFhcNLCITmO3hvE
         AaohTErF8aldtoP3EZmPi8BDYqZskC+0pJ63zfdNT8mAi65nTZXhPzBoiNGhy3BHU6oe
         x6QrVMaykx3BLWabeoj8A2V1f06H5qkrNWuR9p04FK9SHIlBau63AQUz8pJVTTbt4uom
         ny87TcRzMB5KTjFtv7V5M+nKjo3TY1WCy7OL7Kx4mnInPqlgi1obeVn8M3K2+4QLxRoP
         YnKBsmedcj2hxy/X82ycopV0H6zr9YtiiLOetbX5gGDbQ77Y7qAvVfZ0ge7UL3h/ifeE
         bU4Q==
X-Gm-Message-State: APuU4Z9iRpiSquSAmkaWojWwoBbsVLalOkamK7c2IQZ0IY0y88ssyTBr
	XTOAgSBfOabqq2zSCdlSd/lXZ1QVA5hQmwtGBrxt3YtWcSFPRO0hMiz7
X-Gm-Gg: AYBFou2yqa08DxCtg8Pk97NTmAjWWF33qmxyjuxObIehploiuq6b1k/MGf3Z/GwV9RW
	Tu4SX25nzPEo7l8y60z39ojLXPOvYqYCeqxVSb1ZgIUxiI6tf8f+k7XJ1OFhOtA6losM/SoGvn2
	/7tMKmMZst2iu78QoPVYFXGb1B+Lb57V9MLAwfi9CfL0gf3CdLeU63jDoVbzfu3RGOwb+0+HFy+
	ZFERwIRhejuWM0W2fDsSBx3QagpRsRmHbSJaK67o9uhQJ3LDMUU+KPIzNkYhyEbqwNwMJeojYOk
	YqbF7I++jpg1h6AW38791FiI3GpqoqiRnxAkaY3zFirSCcQIuhyOHb2cdIhUUwmRWbYBQ7+Etwp
	WnwVmJu3hvEBgLrG1qkJWeTt2YgO+maV8/YGaqxo9omub9J/c51ejIEbOvWMCxleEk6LMHngAMH
	7nvuiJyqF5mzo8kTvWqBqFr0Uj/ILRJx9KmZDzXTzabgATQVc95CsRCTSBXB553Y18GVRF7v8sj
	XfZN/yO49AfFjDEwBEPotovdHbdaBNiwwTCt5C9hCuXmsKRoo+Jc89pdURLoMrAPzu7zEw1P8Es
	kQM1dhf1nUuzBT6KBg1+4ly4AWADUuaA0wfOS5CmQbLOVfidJkeFPK6wyZDJqyHYGcAKiUx0
X-Received: by 2002:a05:6a00:f94:b0:8b6:594d:7030 with SMTP id d2e1a72fcca58-8beb6f57850mr9049981b3a.42.1794817882882;
        Mon, 16 Nov 2026 00:31:22 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2055031sm3572830b3a.39.2026.11.16.00.31.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 00:31:22 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v2 1/4] KVM: Add the halt-polling time to the kvm_vcpu_wakeup tracepoint
Date: Mon, 16 Nov 2026 16:31:13 +0800
Message-ID: <20261116083116.5893-2-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20261116083116.5893-1-flyingpeng@tencent.com>
References: <20261116083116.5893-1-flyingpeng@tencent.com>
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

