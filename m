Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CC29BD9A
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051819; cv=none; b=hSqk5K5GNelrjiK+Wrh9BKKvCbYPa4TFRcXAP3jl4V5kP3f/G5jXwFyA04x7ekUQP8dAUxroorlsZlXf4UalTPUvkj7UqF59yWc9OsHBDFINyVpMGsjhOyTsNPYKLGGrREfQubL+sdt+m36Di7Ic0SOc0IS3vkAR9hUjL3OX0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051819; c=relaxed/simple;
	bh=EXWGQ3d2DsRzy9C4MjG+80OCusc9j4AMdbCgJYgwkPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOIFIUFEEQr3ehVYooNd9HuWdaE8FdV4fn6/f7YYupitA6JlYDxhUPlfTpRJPedlgQ2dVPCQhnhqY7jIcfetIu1wWyDFFbdevQBOFEPw21aN1Y+eXa/jW6VFOJUHFOq9yfIyOk+zEqdhzGhD8icAEypt9xmuKKQW3FmzuZ5ifFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XryKwCPT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzvNER1D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XryKwCPT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzvNER1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfxOU2dVxeep+fVV39XDWC9/aTob8vYFwfwCGLL4Ttk=;
	b=XryKwCPTJuM/fUbAINycBw8pRv9TQ5yPiZbaQxzoHUItcX+ElEwBHx9mUfH7qFqQBKHxB9
	6+HX9wg/Avl+K4kXSY0kbpblCkV0N6HXd9ZEODv6TpdjjG8E0rC3068uQVjDmZ4Tr01RCn
	gXwBb59A5ZgvxnXAi6zBVnamLdjeRzc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-sCZ1KDDDNOepeMJ1h3O8mg-1; Fri, 20 Mar 2026 20:10:15 -0400
X-MC-Unique: sCZ1KDDDNOepeMJ1h3O8mg-1
X-Mimecast-MFC-AGG-ID: sCZ1KDDDNOepeMJ1h3O8mg_1774051815
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso21984255e9.3
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051813; x=1774656613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfxOU2dVxeep+fVV39XDWC9/aTob8vYFwfwCGLL4Ttk=;
        b=PzvNER1DqGsyZ0B3VVTOA7aChP8xTzYDnsNeoZ6Z+16Fa+knQh0kUe90fg13rXnyLG
         8T8hI7sG/FD0ya7DlvO4YwAkrrE6uydi2dJvvC/uqQgjgL4+NbmXBOgU7gOSHBYuU9Za
         eaFUDWM8E7g/PCWukM0GXgag82eNgzgvzsF709C0Oi7uSg5L/Hbyo76E8K/dRU9Fgw/E
         VGl+6mBkVwxjrL9RWUa6i8TTiCfUT7USZmgI+TU/eO479ooTlpqbRWCx2zzoLaMh93TG
         /RXRnX+w33kg1gVpW6ym0jDSstuPbHYl0qZfJzQxS8QCOlIufSA5IYusuU7e4wDYcEO5
         PpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051813; x=1774656613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bfxOU2dVxeep+fVV39XDWC9/aTob8vYFwfwCGLL4Ttk=;
        b=AWPNAZaTA414QsUR+IJUUpT7o/ae11fTOJ4RBkWKoYpsRJqAfb2Pd8nK5H+VAmm7YG
         iw1nZIv6BhxdrzLF2miu80q04hF8N1h00zXuSVnZPHS4n+D/8QfV6mXV/ARyxfvd32X0
         kEKGimTZ45WzhZEEbSnN7YYslaMthk5HpU1jDK1JQFWb2LZcPmLzAORUuuw16Iy1LUFf
         PtZAbqTRyhRLIJ5AGoS8XZ/wS7yfGL+n9ZLpSX/Lvd+c7z05Xpu238FwLoO5WMSaik9Q
         zJ0ZSopGSJu0t4Ay4qCZQHa/kXl1kk4nMaKZ0lQbcpo/88sk9XVI63NvMa/qN+m9JX6J
         SwsA==
X-Forwarded-Encrypted: i=1; AJvYcCXh4XCvfiGsEx46gWKAH0QMzRofkoPQ91zM4LH+aSKDcy0F/9HHr4lID6lUSZgx263LpEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxygiVD1dn/RRHr2/amH85Mi+BgBIG1+Ni2PPQfn2ojRYcKTudK
	DmwCFDmSRbTzzYWM5HbApc2bEwN/KMfGUd5gmmGqGZHVK0NXG9YBdChCOUAaHadp+0S9HbY7rCc
	DX9ItdfP25gfSAylZJJQhy2SSQIxOuCwHXLYdWTvPkzwlkHQUOcxn0KpD3smm2A==
X-Gm-Gg: ATEYQzzUMtjTE1RDoYornhgA14jxfq5d+kmUYE8wd3mTPSiQ+c9Y/eqbm+0owzz3+Jm
	EyKm0wS9bkKqPPQPo58mUspikExoe6DzneioYUPGitZcaV59SFZwvr8/RPkByl9apq8ZESRyBFS
	b9RXrYpQJJF5psCMtEkCK81LUyduC8tUepEb5wFAhWVhFpTr8UzXi6WIdnCoj43zDh80TDvu8AQ
	pBou7pa5Dt8Kh8LNf0LYzlo3tmauDvuDlRGnaUX6XRlLhO3AKUy4vay75uu7Rjd8ijbRP9KaF9S
	0/WEdDriNceKNqV3ycMHbqpizrbZNcDwexduC9CvrLk4ftep80clXzlnyNIzLWoTSJ0cDWDf5li
	NottoNWTLfZIBoQp3MfOvIZ3iL9eq4u2eVckZ5gmad/KHBWzpdzF75xC6XE7MY1fbL97V9OPHtr
	uO5YI7I5cCL8sPhVQjmMSr7rRx
X-Received: by 2002:a05:600c:35c1:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-486fedb2545mr81295375e9.11.1774051813422;
        Fri, 20 Mar 2026 17:10:13 -0700 (PDT)
X-Received: by 2002:a05:600c:35c1:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-486fedb2545mr81295075e9.11.1774051813024;
        Fri, 20 Mar 2026 17:10:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe967c64sm94008335e9.2.2026.03.20.17.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 15/22] KVM: nVMX: allow MBEC with EVMCS
Date: Sat, 21 Mar 2026 01:09:24 +0100
Message-ID: <20260321000931.1947084-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

From: Jon Kohler <jon@nutanix.com>

Extend EVMCS1_SUPPORTED_2NDEXEC to allow MBEC and EVMCS to coexist.
Presenting both EVMCS and MBEC simultaneously causes KVM to filter out
MBEC and not present it as a supported control to the guest, preventing
performance gains from MBEC when Windows HVCI is enabled.

The guest may choose not to use MBEC (e.g., if the admin does not enable
Windows HVCI / Memory Integrity), but if they use traditional nested
virt (Hyper-V, WSL2, etc.), having EVMCS exposed is important for
improving nested guest performance. IOW allowing MBEC and EVMCS to
coexist provides maximum optionality to Windows users without
overcomplicating VM administration.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-8-jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/hyperv_evmcs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_evmcs.h
index 6536290f4274..0568f76aafc1 100644
--- a/arch/x86/kvm/vmx/hyperv_evmcs.h
+++ b/arch/x86/kvm/vmx/hyperv_evmcs.h
@@ -87,6 +87,7 @@
 	 SECONDARY_EXEC_PT_CONCEAL_VMX |				\
 	 SECONDARY_EXEC_BUS_LOCK_DETECTION |				\
 	 SECONDARY_EXEC_NOTIFY_VM_EXITING |				\
+	 SECONDARY_EXEC_MODE_BASED_EPT_EXEC |				\
 	 SECONDARY_EXEC_ENCLS_EXITING)
 
 #define EVMCS1_SUPPORTED_3RDEXEC (0ULL)
-- 
2.52.0

