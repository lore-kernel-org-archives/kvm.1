Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CE4D9911
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661661; cv=none; b=d0U8tJRZAUBiSGW69/9HVj54ijwNlTQmDmwJFJubV85qtxUzo78A3w+78rmeoSyx/EXhJcxk1kocxpEejV75K5vb6febs2nICqs3nf6o7AOoCJYOgVMP4YJlK0Bab14Y2A7XWIYXTVQgp1M+EyiEb6m7/BDRI2Ro/V4oU65qeAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661661; c=relaxed/simple;
	bh=y6DH3KQUfkL/5UAT9EwePycT8nbFxaivxyvzdJftjPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NB/S2ZW8qBLjK3YHFU4v7M3GXPUYYyLOe4AWQhgRUwWr8ZHMs/FgvvgR+Vs+Oar0aJOXaHkQ26yz5uQkzoatzodO/ifonH2U4jvEi4dkiv0a7VNY9NDFBAxUonaGg4JI0PcLn+2RP4Zj1p+I9Fxa3ONJjM4Uc2thHa0Egrbm8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hMlDfXJa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A1O4MVUF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hMlDfXJa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A1O4MVUF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hMlDfXJa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A1O4MVUF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hMlDfXJa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A1O4MVUF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A379758E3;
	Fri,  5 Jun 2026 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780661658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rW7AEd7iUXH2PCsUA8t6G3vEA4BiKg58gSwZQhwDvbA=;
	b=hMlDfXJaFxzNsaYtwmRYaSBb4qXVE2/Lh+OrwhqRHUc/jHMDczFntlaEVf+K8kPxSf0Csi
	zLP0seRumSDMfch8t/3sFAPFKtKP5UTm2bblrANWsd7pPAfyW0DVDyUl+SvrIXZGvU/7Wn
	xnTL1uE7fbbnO2UbkzNhDN8p+H/RbQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780661658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rW7AEd7iUXH2PCsUA8t6G3vEA4BiKg58gSwZQhwDvbA=;
	b=A1O4MVUFDnn+VnP20BeT3xjF1x6nlMIN2ORU0heznpl7mqp5ChXuYFFEJf6ReDMsyA0qR4
	CXWGDYKFP9/Ll/CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hMlDfXJa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A1O4MVUF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780661658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rW7AEd7iUXH2PCsUA8t6G3vEA4BiKg58gSwZQhwDvbA=;
	b=hMlDfXJaFxzNsaYtwmRYaSBb4qXVE2/Lh+OrwhqRHUc/jHMDczFntlaEVf+K8kPxSf0Csi
	zLP0seRumSDMfch8t/3sFAPFKtKP5UTm2bblrANWsd7pPAfyW0DVDyUl+SvrIXZGvU/7Wn
	xnTL1uE7fbbnO2UbkzNhDN8p+H/RbQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780661658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rW7AEd7iUXH2PCsUA8t6G3vEA4BiKg58gSwZQhwDvbA=;
	b=A1O4MVUFDnn+VnP20BeT3xjF1x6nlMIN2ORU0heznpl7mqp5ChXuYFFEJf6ReDMsyA0qR4
	CXWGDYKFP9/Ll/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADCC4779A8;
	Fri,  5 Jun 2026 12:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jK5pJ5m9ImqkSQAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 05 Jun 2026 12:14:17 +0000
Message-ID: <87951e9a-a43c-4538-9ea8-ee1ed37d786e@suse.de>
Date: Fri, 5 Jun 2026 14:14:13 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kvm?] [kvm-x86?] INFO: rcu detected stall in
 kvm_vcpu_ioctl (4)
To: syzbot <syzbot+3d5461510f8dc4adfe30@syzkaller.appspotmail.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, x86@kernel.org
References: <694f53ba.050a0220.35954c.0084.GAE@google.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <694f53ba.050a0220.35954c.0084.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[3d5461510f8dc4adfe30];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0A379758E3
X-Spam-Score: -3.01

#syz test: upstream master

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4438ecac9a89..d0e250d33ff0 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -626,6 +626,17 @@ static enum hrtimer_restart stimer_timer_callback(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+/*
+ * Translate a stimer expiry given in 100ns reference ticks into an absolute
+ * deadline. Saturates on overflow.
+ */
+static ktime_t stimer_add_delta(ktime_t now, u64 delta_100ns)
+{
+	if (delta_100ns > KTIME_MAX / 100)
+		return KTIME_MAX;
+	return ktime_add_safe(now, 100 * delta_100ns);
+}
+
 /*
  * stimer_start() assumptions:
  * a) stimer->count is not equal to 0
@@ -635,6 +646,7 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 {
 	u64 time_now;
 	ktime_t ktime_now;
+	ktime_t deadline;
 
 	time_now = get_time_ref_counter(hv_stimer_to_vcpu(stimer)->kvm);
 	ktime_now = ktime_get();
@@ -657,10 +669,8 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 					stimer->index,
 					time_now, stimer->exp_time);
 
-		hrtimer_start(&stimer->timer,
-			      ktime_add_ns(ktime_now,
-					   100 * (stimer->exp_time - time_now)),
-			      HRTIMER_MODE_ABS);
+		deadline = stimer_add_delta(ktime_now, stimer->exp_time - time_now);
+		hrtimer_start(&stimer->timer, deadline, HRTIMER_MODE_ABS);
 		return 0;
 	}
 	stimer->exp_time = stimer->count;
@@ -679,9 +689,9 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 					   stimer->index,
 					   time_now, stimer->count);
 
-	hrtimer_start(&stimer->timer,
-		      ktime_add_ns(ktime_now, 100 * (stimer->count - time_now)),
-		      HRTIMER_MODE_ABS);
+	deadline = stimer_add_delta(ktime_now, stimer->count - time_now);
+	hrtimer_start(&stimer->timer, deadline, HRTIMER_MODE_ABS);
+
 	return 0;
 }
