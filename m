Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689018;
	b=hCK5LMgrP7p9X5N011KKcefpBZQqzkUOyJsSpfgxnYYU4EyR/nxKQ8s2+KDN6stiTmUh
	 JAQrXdNkIlrZgiZjM/xTA8+11lZLaqUDd9s6cJisiH3gx+z//WYsGgSl0oDqwqPcX/BxL
	 LFIeJp4krNTelTgG4SCoTvYT1Nv+/WCCuv5vnH4ebFEoTvXZQUYwgqAhtK+3yNWr4GMA7
	 DMYumc5TgFAXztqqgcIATLKjJpzl1njiyF4ncep1onSZH9DllgpDjdPig5ZvXsknCf/A3
	 UgwOXlUUNyzQdLOKO3QGiDdpGcAQAmNSmZaR2Sq67pcR9FfgYJuSamWGaYPvsZNllhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689018;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=o0WqywVfTuazQE818hdUWqKUKii3/++nUu2snqE6U1c=;
	b=bGcOZgyL/5Pa1mFM+fPv/SVLySYTTAYlfxXE2aOad4nqMlhsViIF4sILrp/BRyK7lwQs
	 oqenzgCYY6d0OyD1dHCFiOFIHWe1Zo9pBJ2cCCGMpTwrqwKQvTbro8Zj5n4Tb37d7E2Gq
	 JX2O/rIvQyVCoa0g5tNt/BJqw1SJEdQxu/5/TDpoElPt3cKY0h796rV386GIckPFs+1lZ
	 NvsF1CXOui9EUp5CRZ83RpwTI8MdRVK7mcuc5Z+xoPlGI+C2iAVYLhnD2yKSUqVeNiIKu
	 nepRp33cvts0RKm5Ewjd0CytwntHz3Ph1TBwQ+lXdH2jySPLahAHHLf6mEHTlNswfGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vf10WhrG;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF360A2610
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 10:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BBF360A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vf10WhrG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795689014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0WqywVfTuazQE818hdUWqKUKii3/++nUu2snqE6U1c=;
	b=Vf10WhrGPcDLJ7DNpQ3lV9CMqibRaLympIAt8KeAIIiJKnMPspYz31pjw7cN8ek1bcnYBB
	+q4G3AMza48XmJfmEVYC5okAxG05P9zpfnpzZqX8+dPSw0X7H30IYSy7hQ2rGtWACkWT5R
	6ALkHQPbamWjYE6nDQnXd1k70yxoJjM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-Y7Z6Q34fP7mM_9R6Ilsh1w-1; Thu,
 26 Nov 2026 10:30:11 +0000
X-MC-Unique: Y7Z6Q34fP7mM_9R6Ilsh1w-1
X-Mimecast-MFC-AGG-ID: Y7Z6Q34fP7mM_9R6Ilsh1w_1795689010
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F92A1955DC1;
	Thu, 26 Nov 2026 10:30:10 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C0E01956086;
	Thu, 26 Nov 2026 10:30:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com,
	andrew.jones@linux.dev
Subject: [PATCH kvm-unit-tests 3/6] omit "#" from printed command line if INITRD is empty
Date: Thu, 26 Nov 2026 11:29:59 +0100
Message-ID: <20261126103002.2145135-4-pbonzini@redhat.com>
In-Reply-To: <20261126103002.2145135-1-pbonzini@redhat.com>
References: <20261126103002.2145135-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If INITRD were empty, run_test would still print a "#" at the end of
the line.  Simplify the code and make the result nicer, by making "#"
conditional on $INITRD rather than $ENVIRON_DEFAULT.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/arch-run.bash | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
index 2b3154ce..f585de7b 100644
--- a/scripts/arch-run.bash
+++ b/scripts/arch-run.bash
@@ -3,9 +3,7 @@ run_test ()
 	local stdout errors ret
 
 	initrd_create || return $?
-	echo -n "$@"
-	[ "$ENVIRON_DEFAULT" = "yes" ] && echo -n " #"
-	echo " $INITRD"
+	echo "$*${INITRD:+ # $INITRD}"
 
 	# stdout to {stdout}, stderr to $errors and stderr
 	exec {stdout}>&1
-- 
2.56.1


