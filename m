Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868240;
	b=sf3E/jY9yY/KjVwggRftYs47mmXULLyovfwU30T6GFzupUT/RpyDw5pdpIsVy4TS7QPp
	 CAlLlTWTa2W9LXF68elgAWTUoS11WlwFcM40e7bbUxFSyZirU52bQMbTSq00ymm3VtJc5
	 KVzW0j84GQYmtc+ryJMnxJ0Ks/A/3tCw4l2ceA4Phkc2bS8kWL7IMXBebl9Ffw6BPCPEs
	 OqWyp/0rFkYLyRdXBWGP48Ha7hlgH205ETm2aGc0sk53EAyO94w2KZMUhS9gs0WV4aRD8
	 p/Im7OAB6otWCqY2lTmQzYtmMza2ckH5ihV/ptai6PYDz4W793InOX1mIrqCGQ4TGuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0NeepTMHSBHD8uMS1QlFPBjDgl/bEPnqXOkPsb5thzw=;
	b=VN0W5/064k3gea6eszScV1XN7sOB77iKkghGhV+Z1K7/qhiAWaMh19A10y/Ph1K/Rs7/
	 kdeqXbabJVU3OlinwGnQM9CdejNbgmJvQve2SQUVsgcQTBjTwQaNRGB0kkUj0od/2y0ZB
	 7QTxUIQ+6krOWFE1WvPePBKCF3ZHYQJIWhfaEmvTz0upOefziCUET4t8rEaV0LU+za3rn
	 lTRT3c5Xka2dJXnQv3IYXa8zlYQuX/yp7M8BeOgkpp2F9wYWQckJMny4ZfVG9WiqDz6KP
	 LOiiP7Lxk/1uAvhXXSmSka4xDUFvUedsxisR/T1hvBrOiEqlMpsmVEIC4/L6rgDGAOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gr1IGMUr;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8632606A880
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 22:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8632606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gr1IGMUr
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so1587834a12.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 14:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794868239; x=1795473039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0NeepTMHSBHD8uMS1QlFPBjDgl/bEPnqXOkPsb5thzw=;
        b=Gr1IGMUroQDX0bAcGHB4MVIIwx4BwI73Uc2wG9+vEd9W3f0S4eb8fAhakXZKbGu4x4
         KyKnfyVT5U5K2lozfCe0gxLeAjujKskrf178l+R+HEY6Us3ZOuDNJd/NB6Nqo32IAmN9
         II9Cpj7gKKA8emHVYWWw2gT2FYLgjZ96Qv6zM/Ijo8ME0vjYd5pFUZ6yJ33qnZ2Xum2V
         y1SfMDNAtitep7PSZ5V/bda1c9BFel978sZKWvPeijcc410+CStgIzVcWZrXUnLk63x3
         uhOUe0OX6mxYD+83n3ylih3AIGVU7vsT+t6RwefpylYqcBQmAi7hFQcs8ccnsflVYMcK
         1cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868239; x=1795473039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0NeepTMHSBHD8uMS1QlFPBjDgl/bEPnqXOkPsb5thzw=;
        b=SAA7DFXyAVUty3iR2CyQd7Hae4DHDAhA4hpYP4kxLP2dggmT+PRfR6j1jrkMTD/fz2
         rysJNc7cIrqA83hmZGHE0ioDzUBnmatCUxYS0It7gWr6z/ROxF/nvjkE/CHNj7NznUsi
         +NTBWvls60hfZ73X92bw8Rw2ndFo6clHqnvLOx5TGIDr5JHQkGOpVqv3JrLUNDeRSyWE
         QgHHUvWHoUb99mJ8RnRCNY90pbwK4ROzEwOLdM7fHNJzRM8Pv2iS6pRzoRg35dxwSqK2
         Y5/9a3VawwkrfuN6UOp0XqUTrHfLyRvJe8PJf0eYTgxCb0+GmGFbddMaS3DdXzYd5kda
         rImQ==
X-Gm-Message-State: APuU4Z9Vg58hPiJycrUpGBeEEUuhS7F6HTmoT9RtFUfz0fhqvNUtqEPz
	8bjtX1K4xaJf8iyIsNN4HGd4gH2C9DEtDiosiWtZh7dgW+ic9ir5SHq8
X-Gm-Gg: AZFdTZcR/wULhiQ7iqGezVZVZmCyscSV06qDmuAJ4yolfZia02ypTxpgYK6rTxYBEbM
	Iv5dD1tZ+H4R6BWUEpTejQ7w7PmILU74ZoQrPEW6ZjqYiQqnZUsvBmyLAbdMAFX4kMVrlNUOVRh
	0zqozGc4ONgNdTYDf7SQy0t0kPX/J0oUWS41+rEOQALz00kwr1yQhuzKk44OtUWDHF9X6KWci4m
	OAhsRSv9EznuTtqd7p0kM+RKzX5KQBSQk8VdXahMpKKu3nHS7KemIWxWlB7Vr3WKJmLKxGfzReb
	4bq8LicGG/7jS8kcbF8EZ/Wje+AFtMKxMcH0nxOm0Hlmf3rvXzhKMYunSD6xHN8hiuEyCEyvX38
	5mMi6WF7LLqEEeadBMtu6fIHID9U3iuXfjufgDLx9E94qP9MQofIvubXdxkag30GgPnELNkYhkC
	HfhoJk1JH+e9+qYf4PVrVIPsEQmG5auvAH4xRj+hYhaDJXPX+QvTdLoPb6gWxAmGwr+cQNzA2Gz
	n/JNvInqJlYWPs7pcZUv3PIu6wwRhx6PHTYntA03AJiIKj+av6gPRSCb667U6EsE9o0nP+nNLnD
	QJz/NziF4V/QJHEV6vPJcIVxDq8xUs0nogpsM4cQwXkH8Q7Rg7j9UzARV29hDetEgj8aKxo9wZn
	eoEXf2zye0AKe2FG2PkzVxwkWGCcuCp7IOSGFCOZ9yw3D56crGq0SM90wEU3HHyIjjdCPNb1c8s
	nNaqXGWcnuHGA=
X-Received: by 2002:a17:90b:440b:b0:3ac:adce:60a8 with SMTP id 98e67ed59e1d1-3b1b07ef8bbmr10811519a91.5.1794868238728;
        Mon, 16 Nov 2026 14:30:38 -0800 (PST)
Received: from cs-arch-srv04.cmpt.sfu.ca (cs-arch-srv04.cmpt.sfu.ca. [142.58.10.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac255634sm944375a91.5.2026.11.16.14.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:30:38 -0800 (PST)
From: Mahmoud Abumandour <ma.mandourr@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 1/3] KVM: nVMX: Fill VM-Exit instruction length before saving pending event
Date: Mon, 16 Nov 2026 14:30:31 -0800
Message-Id: <20261116223033.3866283-2-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116223033.3866283-1-ma.mandourr@gmail.com>
References: <20261116223033.3866283-1-ma.mandourr@gmail.com>
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

Fill vmcs12's VM-Exit instruction length before calling
vmcs12_save_pending_event(), so that the length it saves for a software
exception isn't overwritten.  Commit c3634d25fbee ("KVM: nVMX: Leave most
VM-Exit info fields unmodified on failed VM-Entry") moved the assignment
after the call.

L1 sees no difference since both lengths are read from vmcs02's VM-Exit
instruction length.

Link: https://lore.kernel.org/all/sashiko-outbox-179791@kernel.org
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1a98f28651..e8cc0fb308 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4741,6 +4741,9 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		 * instead of reading the real value. */
 		vmcs12->vm_entry_intr_info_field &= ~INTR_INFO_VALID_MASK;
 
+		/* vmcs12_save_pending_event() may override this. */
+		vmcs12->vm_exit_instruction_len = exit_insn_len;
+
 		/*
 		 * Transfer the event that L0 or L1 may wanted to inject into
 		 * L2 to IDT_VECTORING_INFO_FIELD.
@@ -4749,7 +4752,6 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 					  vm_exit_reason, exit_intr_info);
 
 		vmcs12->vm_exit_intr_info = exit_intr_info;
-		vmcs12->vm_exit_instruction_len = exit_insn_len;
 		vmcs12->vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
 
 		/*
-- 
2.25.1

