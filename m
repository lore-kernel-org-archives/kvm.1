Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878116;
	b=ymxed6WsQj20zf+8UDUCJZ+7RHO0rGKVWyur04x582ivcoXtPXL/znGRTcXQPwTyCHyF
	 WIONGar5AlOk4OTX47iM/ErSzaEZNp8TNU5KbivEVSWRZ7KFSALyDTMCT/XGFVXiCVdJE
	 /J+DvUphsl9cFX1Ws5prwSF6ccqjvf0UOLn2eTLcMr1UPufFlRMU1WQYBWghAKo9B0kY1
	 LSwNe4NwDyLxDv1V3S9TasBV/NCjmbhjCDgvqs36VeSKDqAeXvz5ivLjYvSETRV+n0/eM
	 gSzlecHxbdPmel/kONB/c9adrADkeDynN+YM1wsFqtbGE4/E5zjBwLRLW1Im0hP4eJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=OfKf9iYa0JD3DIaGQL4jdglFjk83Ku8ktmH0JNxa7Ss=;
	b=i18sz7cAeYOe2YLqVOwZqbKovabrRYSH3hAs/QzMF0S2LX3eeqsaUHSGFnf4cAVyqasF
	 zLbR+fd2wQ1mNlbLGKT44rI/z5bRbCzTTreVrVYI1/qWkUxPGOZ5JVeiD/K1oDMhO2HYR
	 dqidRFRWXE+FIoEkGI8WE6X1z1FHOQRImfYUePNLZ26TYvwFmZiYK+zFukTITmCr3Exiu
	 wKvxsPUjH5KX0toG3Fmc14BacueFIuF7AHyXVXqUzphIfRW+UJiMRnHSATZOSU1vpPq6V
	 vftZukj7xnMUrE/aAnX1BVN0rAIypg/K05zCZB8T3rPi7llWq5sGhQJ0XRbhDxP/Kqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ckLzIPD9;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB2606A32C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 01:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BEB2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ckLzIPD9
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed1fbae872so25061075ad.2
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 17:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794878115; x=1795482915; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OfKf9iYa0JD3DIaGQL4jdglFjk83Ku8ktmH0JNxa7Ss=;
        b=ckLzIPD9h52dG90sQPAujcVw+2zscj8VjKG8x1FHk5Bpokc4HRUfmh0tdIhgTsdwty
         AqZRzGqp33Fwv2L4hCIzEc2Lf+5P4bsqARUJECvmbJn4bB4za2cvUGFh/hO9JTr4hjdM
         fflzORtprz+GFDzwKcvCJ97QL8oIo6pSg3obKum30idQiy0LPeImzMv28ypHWyi/n+R6
         zsnVdZIOpybZgeeJPOd/o2VON3a140fZ+/plFVIhmy6OpQkzhpNB51vGvu5Ej1vaV+nG
         qU1O7aJq1ut1cdO5HfrYgYqnshRbY2oWamWq+6dZJQq/Z2O44NWs4UqYYbUQyH+4rAY3
         uwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794878115; x=1795482915;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OfKf9iYa0JD3DIaGQL4jdglFjk83Ku8ktmH0JNxa7Ss=;
        b=EtOuXPYQ4Oo4IOi+pXeZII5SjVoeh81TEFJea3I10YbjTsfBk9aZT+VSYQrSH7T8gy
         RqRAMoyYdHGALvLim+Nly41sZHWd/am7yYQAkJOImrEsCwb6vCqYVSw/VcWWUPwmQ5tX
         TSdywm0rNO268uqY76PTemPgZEw4Wo1NglkSJQxDlExOAwyXgNmua5KgyCsykDLKXUwe
         vNJ9sL/R++Jsp3+PDqa48UulcrlxJnItEzX6vTWpDf1ZjuKpKLhjCH95X0y3umdL/xel
         w9GYURaMTEwJ8aCvVrbb5Ri7St/k2mgyrDeudw+8X1ay0yz4k3OeGEpEZBsEMHPCoX4R
         0/iw==
X-Forwarded-Encrypted: i=1; AL+hErHFc075GSgQZgHRb/tXmyx5kYbkAPY7nGsKQI3fG3A5zcrnKbza6a97U7Y2oOb1zJqR5r0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kHiGaUXeGXyWsjU7rEM3taboLpGXDFo6m1z0LTDomYRITSm4b
	ZF9MhHuvCmgrgijS7JsyLQXWjz5VYcZ28mUYeC4DHP9w7T2Ix2QIbBXIg/s2xWZFnolBnEQGc7s
	vIFxAkA==
X-Received: from pjrx21.prod.google.com ([2002:a17:90a:bc95:b0:3b1:317:bac2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f86:b0:3ac:7556:8ee0
 with SMTP id 98e67ed59e1d1-3b1b0b666c5mr12537753a91.19.1794878114705; Mon, 16
 Nov 2026 17:15:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 16 Nov 2026 17:15:11 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117011513.39419-1-seanjc@google.com>
Subject: [PATCH v4 0/2] KVM: Skip mmu_notifier invalidations for gmem-only slots
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="UTF-8"

Fix a lurking bug where KVM incorrectly prefetches SPTEs for gmem-only memslots
using fast GUP, i.e. VMAs, and then skip mmu_notifier invalidations for
gmem-only memslots (because as the name suggests, KVM MMUs are supposed to
only get PFNs for gmem-only memslots straight from guest_memfd).

v4:
 - Tack on a patch to disallow prefetching gmem-only memslots using a VMA.
   [Sashiko, Lorenzo]

v3:
 - https://lore.kernel.org/all/20261113164000.467175-1-seanjc@google.com
 - v1, but with a different changelog.

v2: https://lore.kernel.org/all/20260714160411.302386-1-alexandru.elisei@arm.com

v1: https://lore.kernel.org/all/20260615155244.183044-1-alexandru.elisei@arm.com

Alexandru Elisei (1):
  KVM: Skip gfn-based MMU notifier invalidations for guest_memfd-only
    memslots

Sean Christopherson (1):
  KVM: Disallow prefetching PFNs (for SPTEs) via VMAs for gmem-only
    memslots

 virt/kvm/kvm_main.c | 7 +++++++
 1 file changed, 7 insertions(+)


base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.56.1.703.gf848ed807c-goog

