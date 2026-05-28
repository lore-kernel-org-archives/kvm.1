Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39DC388860
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966849; cv=none; b=IYRrfmjiKjP3U5dFkw01RYqwxyj5z1WlvUrC4dfdwiFvXsqVzJS6kJgqcXwV4SjE/G4C1Q4shpN4I1rtD2VtSzRNlPTD20BYjntnh1vAz1UiY7RGCfCJehr8/P005kOrSPOrvYNlEISTN7NWVkI4RbA60tFGE7SIZy0JetAxvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966849; c=relaxed/simple;
	bh=1mbzqhm3jy/Z0crtDf0D8EOqHaTPu3u7Z/3xM1xXZGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ/5I0yJ0nDukB04touBaDQz6+nJC2dOlY6TdJ840HFTfiOUd+yQUouaCM5fp2FW7h8PcS/RBQA8IThRSZY9kIbabdSgvH2VP39Nzwi+3OMN3QFKjULWqYEFxRDVmvJAB2JuluQoSjhATtoJ1gAohZ0uN0maDvJeTpV8g5ceBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p7pibjJY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p7pibjJY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p7pibjJY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p7pibjJY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9819166E88;
	Thu, 28 May 2026 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779966845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DAIrNcZ6OVljSwBirP057gz50SAEW+xPSlSG6M1iNU=;
	b=p7pibjJY7EOyDxPjZYv0y1QDj95G0GVdOXf7vtRV1bR3U3YVci7q7dQc/LRavWoAbMlE7I
	AuFCj5MSfYV3iQrd7vUX4TlCc4o0EF8qOs6C4up26MAIaUlPsUb3+vuodWL+kg+25U6Xw2
	CWl9wz4KAZxJoykNBJ/hMWyhCMSx82g=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779966845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DAIrNcZ6OVljSwBirP057gz50SAEW+xPSlSG6M1iNU=;
	b=p7pibjJY7EOyDxPjZYv0y1QDj95G0GVdOXf7vtRV1bR3U3YVci7q7dQc/LRavWoAbMlE7I
	AuFCj5MSfYV3iQrd7vUX4TlCc4o0EF8qOs6C4up26MAIaUlPsUb3+vuodWL+kg+25U6Xw2
	CWl9wz4KAZxJoykNBJ/hMWyhCMSx82g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5832A5AD61;
	Thu, 28 May 2026 11:14:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tNx0FH0jGGqrMgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 28 May 2026 11:14:05 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 1/5] KVM/x86: Change comment before KVM_MSR_RET_* defines
Date: Thu, 28 May 2026 13:13:53 +0200
Message-ID: <20260528111357.264809-2-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528111357.264809-1-jgross@suse.com>
References: <20260528111357.264809-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]

For MSR emulation return values only 2 special cases have defines,
while the most used values 0 and 1 don't.

Reason seems to be the maze of function calls of MSR emulation
intertwined with the KVM guest exit handlers, which are using the
values 0 and 1 for other purposes. This even led to the comment above
the already existing defines, warning to use the values 0 and 1 (and
negative errno values) in the MSR emulation at all.

Fact is that MSR emulation and exit handlers are in fact rather well
distinct, with only very few exceptions which are handled in a sane
way. Negative errno values and 0 are fine to be used, while the value
"1" is just used for unspecific error cases.

Drop the warning comment part, as it is just plainly wrong.

Replace it with a statement that it is fine to use negative errno
values, 0, and the special MSR emulation return values defined.

Don't mention the value "1", as current cases where MSR emulation is
returning "1" should be modified to return a negative errno value
instead.

No change of functionality intended.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- instead of defining new return value macros, adapt the comment
---
 arch/x86/kvm/x86.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 38a905fa86de..5ca2f3d44092 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -675,8 +675,8 @@ enum kvm_msr_access {
 /*
  * Internal error codes that are used to indicate that MSR emulation encountered
  * an error that should result in #GP in the guest, unless userspace handles it.
- * Note, '1', '0', and negative numbers are off limits, as they are used by KVM
- * as part of KVM's lightly documented internal KVM_RUN return codes.
+ * Other than these internal error codes negative errno values can be used for
+ * error cases, or 0 for success.
  *
  * UNSUPPORTED	- The MSR isn't supported, either because it is completely
  *		  unknown to KVM, or because the MSR should not exist according
-- 
2.54.0

