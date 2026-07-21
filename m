Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CF3E49C6
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653577; cv=none; b=ZKXKqSvtrd7lYb6oLZIUXJ9fPN6eMp69kUe5Ns5nLtAq5tz8oung+baO5Be8dEwiSRLyBpch5Aqbyh4nv40QvskRLnK8W8VPx6TWV6I1WkxuSoJo1rZJ2y5UyAPgyy/dj5YOo73w/qFpEOA5Gb76pIr9FqZRevFpvqumk3IW9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653577; c=relaxed/simple;
	bh=Z1kfHjZshRyq0OhKtA+4Xwyb45jgsWJ5RkfvK1EhOX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZDa/glcbw80EvDMxiuo6yDLKsfPBnxpp5438OndYJ1qjL6pYlkxRwxulBS/lSTTVf1g25btkYo9O1u4X7C1KDfKZ75WPHt77t/py70ja9nkh0QY1P/tS2frrmFG3UdajN01ISRPBLA3r1kwQ583z9UL2FDq6N+1eCpiQu27Zokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+1nXKVu; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+1nXKVu"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso2686712a12.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784653575; x=1785258375; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpgRh3CeErOqYeAN760I7EgBZOZeFXDcwxkCd+u/yDU=;
        b=S+1nXKVu4AynIbk7uv38BmmPZoxDdLC9ConuFm6ia5Je0h0B+y8EwMSWznWpltNXWX
         XG/Un9jV63TAlZMfXuoDtcEYG06IbQtJUlVJyicwF0iR8jmYR5Ruj6a7JxL2VI5Q29By
         lCH3BiC4cz6nRrrsuCfMaNNN01Nw2jTZt6KX3eWnqnnMD8F3XqBfy2S05drH0tfak+FL
         1yqQcw4CBvfbAorwsOS3xj2OAKZQ+lawNRbR+PJw+cIHp71hAHAZaIENTgBNYHAP1MYw
         DK3e98z0dD53eQXA0XOLLy1aZ8ifet5Cs3J6KSbIwyBiQT6mW3rnoxSppIPKE15CM2wg
         ji1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653575; x=1785258375;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TpgRh3CeErOqYeAN760I7EgBZOZeFXDcwxkCd+u/yDU=;
        b=r4errCNxQZ6Sqb816Vh2sXiPxe0HOIyC04lhaz3G3rGatlxCL3TA76cJsq8ituej6p
         ap/7Ve8Vpo8wpPTOXMI9J65xpOy8+65OcUX44F7jIVuHWyrgXzFh/h0w8+PnUwk+Gelk
         X9QVGBJxwK0XU/2+Nhr+AhtEPf7hUnLFxfvn6o2XZjlzPcV4KJsTxv8obS6BnslL8b90
         o2NWyr7GPX08y1516B674RZ7oTWnJ6Mc+M8tcc3RqoVtygWBEWwd4UBZ4Y0sQ6AA249H
         ZY/qAEKWHKgSWC8ddA9n9gn6HTR7fqEgCda3bEHTUanttYizDLd7+oOg2ur5wpGO3Uja
         vV9g==
X-Forwarded-Encrypted: i=1; AHgh+RqDAqDMh36og9O03OlRoTZGyFeaTxQjsIJun8fkwx1zXChYpOu4oR6u487z4eCUgchvjcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vPgiQYquVUV355rQ8HvckWMl0vJ4Wu8TQES2Sl0u0hPehfAb
	e17+PHkCGK4I2BFXOc44/MlumRAKHOKZHRi1VykzBjxuH6LMJaniI0LDHzbW1qJ/Xd6qAtHn2py
	B+38TOw==
X-Received: from pgmk20.prod.google.com ([2002:a63:5a54:0:b0:c8b:19f4:6228])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:db09:b0:3bf:b885:2fae
 with SMTP id adf61e73a8af0-3c3ada8bc69mr21255876637.56.1784653574972; Tue, 21
 Jul 2026 10:06:14 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:06:14 -0700
In-Reply-To: <20260721164746.376551-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721164746.376551-1-pbonzini@redhat.com>
Message-ID: <al-nBuxK5cOcJUsz@google.com>
Subject: Re: [PATCH] KVM: VMX: add memory clobber to asm for VMX instructions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 21, 2026, Paolo Bonzini wrote:
> VMCLEAR/VMREAD/VMWRITE/VMPTRLD access the internal VMCS cache, which
> is not visible to the compiler; without a memory clobber, the compiler
> can reorder them in troublesome ways because "asm volatile" and "asm goto"
> only protect against removal of the asm.  For example, placing a VMWRITE
> before the corresponding VMCS pointer is loaded can lead to corruption.
> While none of this has been observed, it is better to prevent than cure.
> 
> Likewise, INVEPT and INVVPID access the TLB and, even though in their
> case the effect is only visible to the next VMLAUNCH/VMRESUME, it is
> technically correct to add the clobber there too.  So avoid any urge to
> special case them, and simply hardcode "memory" into the clobber list
> of vmx_asm1() and vmx_asm2().  __vmcs_readl() open-codes its own asm,
> so add the clobber there as well.
> 
> Link: https://lore.kernel.org/kvm/CABgObfbL3t21yVeSwiLSjjOUER+rTYDPHYAH9YU4TWGRjx6XHg@mail.gmail.com/
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
