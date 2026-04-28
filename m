Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547544A710
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396570; cv=none; b=Iz8ppoZuN3FfUp03PQH2vGJk07QSWnwCD/6ctvf8poprKIch5CsVUwnv1Ib97ZK6ZE9p/8n7R1nFyw14hPwUucy1JyhltanH+hfU9kZ7JN5kyqssA1iHQ5Hi3+SxwDLAg/ySw0sSf4Mexegs6P1DLp/rUcAMkbIdWdlO6NOHYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396570; c=relaxed/simple;
	bh=4K6X69sxUSTjjaQYXx/sGZnSsoDkoIWPQvxXhPP9qFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XOu9Xf2S8DQ2xFpxNXOWCbyjWrjgCsI0Zt5kl0dO9fsFlOLCE/ZHDC4izgffM2Opby8RcT6ohXu2a7kKA9C2gqLIdd6rWB/CA7VeUGB4DiFi5FgJwtSpzNnooR4KHR6ZIP7wpYVaojyR4z53idA5wTNxUgTpJFf6p1RcFcMtc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlf/IXSD; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlf/IXSD"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso7773890b3a.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777396563; x=1778001363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=t8oFC8hchhcmLP72j6OqZ0VSXo5ZoW2JLZ8cqLZ4cNY=;
        b=mlf/IXSDlLriHY8BzC/5CEOBH+ie1scfuiWqHHL9xtvwNiUTvwHwhCeQ8OSO22qlAs
         qlMaxT9Cmv3lhsYRfPhHZ5O2EP3ZxMPRDBmdqn7g02A5E7fJFkq3upkXe8wzQUs1C3HZ
         0miqxmtIc5OEFZwOUv2ArDLaqTBUAw8FOki7cHnKnX9qOxq9oK7eql8TXrW8HYqbmjc8
         lQghZpTNTLMQIgARIiiuCknBxvKpnZ2IRqg/X0JW4l3oSXmxPAu+wTv9Pq3ZKMtA1Pao
         gUv6jA7Lf4zO63YUxS9Rmi9rAtShad+NH4Xj3VWFTRCAYmFEhSecqM79UVk77XP4fZsc
         PsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396563; x=1778001363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8oFC8hchhcmLP72j6OqZ0VSXo5ZoW2JLZ8cqLZ4cNY=;
        b=gfO7hPpIxQjyKQ6Zi3lM0PCQlJr9Uh3yOY9Y5Pneio4cIDnVhC18ccXUVpJ6tDm+U9
         MeOEaZKjjcZwrsnJ5wTnhQPSozYPxZXtJFD+o6G2TmIqS2vtKJNZRnZnWCQqQz/81qPb
         c8R1KerpHMNHoSNRmH/+KCg63fO83roAxxqMThZa25p5HlteR1p/xGzngpxUFi30yiAt
         P1zr++tNSutLPA/ZxbVd/kSbW2/jRbJDVauKiRBMFra4+SLyUbVl8cYgdEjbM2qlnlTl
         7MQobv4qCqDv2JhvMOy8iWW79lX2q5HNXADiXAb39z6j8Lj7OuvVbtuqXs9ysfRVojZv
         5pjg==
X-Forwarded-Encrypted: i=1; AFNElJ+c112c8gJ8oYmn0hvyRL3GG5c98AxX9uiEBdP41vS806W4Tjv1gvhBb9daMnYdcdh2ySU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5hyJyl4ZUjFkj0MT9vHmPd+xZhJNFoOBcuD5ummAUf9HmPpmn
	coC1FzQiTlTJoKY13rVo49Vx823HLHWG1pfiltATqhwZp2Iveb9oT5BGVih+6tDToOSKwh4XByu
	zcDV9TQ==
X-Received: from pfoc9.prod.google.com ([2002:aa7:8809:0:b0:82c:90c5:5e0d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440f:b0:827:441a:c970
 with SMTP id d2e1a72fcca58-834dda62f5cmr3900648b3a.6.1777396563234; Tue, 28
 Apr 2026 10:16:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 28 Apr 2026 10:15:41 -0700
In-Reply-To: <20260428171541.1342335-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428171541.1342335-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428171541.1342335-6-seanjc@google.com>
Subject: [RFC PATCH 5/5] MAINTAINERS: Add myself (Sean) as a reviewer in the
 main KVM entry
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Add myself as a reviewer for overall KVM, as I have been helping shepherd
a decent chunk of the virt/kvm commits into the kernel over the last few
years, and I expect to continue doing so.  Of the 270 non-merge commits
that have been made to virt/kvm since v6.6, I have committed 127 (~47%)
and Paolo has committed 117 (~43.3%), with all but 5 of the remaining 26
coming from non-KVM folks, e.g. from treewide changes.

Note, this intended to purely be an efficiency and quality of life
improvement, for both contributors and myself.  There is no implied right
of succession or anything of the sort.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Anup Patel <anup@brainfault.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8dd5cdbef66f..a9f2a7737547 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14034,6 +14034,7 @@ F:	kernel/umh.c
 
 KERNEL VIRTUAL MACHINE (KVM)
 M:	Paolo Bonzini <pbonzini@redhat.com>
+R:	Sean Christopherson <seanjc@google.com>
 L:	kvm@vger.kernel.org
 S:	Supported
 W:	http://www.linux-kvm.org
-- 
2.54.0.545.g6539524ca2-goog

