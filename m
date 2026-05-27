Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF34611CA
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905414; cv=none; b=CziV2mXhBgH21kjjMjjGPP+Cl+wVrVImzRak/yTV/58SQru1DPPp57pI0EtLDERC2psVFOH8CU8CFDj178kk1NS13sl1cAAh019tO5FkI7aUCpGiX8V2VIK1+tkN0xW8ZqCv2+M3vS2L+T4XCYohB+0cx435oIlOkpQIPM8tLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905414; c=relaxed/simple;
	bh=bjTBiuEI2Gb0yoOHDpPWFZ0LkmXS4yuNQ+J8WdNX0v4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GxOYbOYcD6fqUoFPy/DJiHl9Yvn+0YZa8eNsQcd1jthsZqYSZTe46y1ucabgn/NWPBMgzp/+t9p585bmADBGcs0CG8Yd6r1K6qWqTLy/zp0H+8Gxhj7bOnpUFbGnNUj/IdlIL3Z+dQJ1esZWnUd//Y09iIw8Hk/wv4Lgn3DndoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tgasfQ/Y; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgasfQ/Y"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c827adbf00cso5392944a12.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905412; x=1780510212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0CdVfxKmDIVL3Py8q8FK9CkzIjMccvxEZLs5IONfFE=;
        b=tgasfQ/YInhvu4KsXz2EBhsx6G+hpDumHh3FdngbKOF6xQx6ofAhaNk6nDIYaGYjhr
         O9TkOzCThy/8LC7E4iU63OE0ELXukvX2Y72V+jfVpg8M78Vktap4bU0tq6NefXsEx4fx
         7MZF0jLqrXkanyu85AkPLQ4hlXecZ4IOVykF3EAHLTeR7bu2ZEkRi16QYYxyjFcXX+vo
         gOYhWAWdGABYJPk8pCubCBDrEKfkLBBU8vGd8+tObQ0OZ9zzLFOUCCeDNkvKJne2+oSJ
         7iluVLoKLvAp7BcqVxUEU50oz2LHz6UmucHAuxa9Cnm851rPtdsyeFuqgGrZmJkIP9Qi
         f4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905412; x=1780510212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0CdVfxKmDIVL3Py8q8FK9CkzIjMccvxEZLs5IONfFE=;
        b=JyUzbDP3fQPH2PPdUPu6kLGJ/zAMuhYbWqnOWfwyjMZp3wLWoaoL+dELxMVQ9klKkU
         9naa/zQgyP9yuIDqMnKU7+NjRTe37xsGQwtJZPeTCUrWgS7LTiRd7V07+CCQOo0XIH1x
         +CO85keG/4vAwLepwHP1LqFIrRz2O2U5pyaikSN0bX+eElHjRjzD7fzsqdXet+knJ+s+
         YDi2s8ZObUN2ero4OY8UtFaPxMG1IAPuOR+Pv2pW+q+9hrm0RKqDaF/Och7z5gofCeie
         JA3pOdE/xys7364gVqlSK1gqoJRgYwhYtW1dnhUDtIvZCBurpcJGp7WtU0o1xoN3qTjV
         52IQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uHpVwNYv95sxqs3Mt75+SFEHra3icdjpqa1BgCN7KWQVJ8A3NdKJWsCTbHAhV3ues/Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgz5Eakz9IRBIk0+HPViEtnjzbHn5tGtAKHmTkBBwfLR7B+xF2
	gRXdhaYv4EwVvL8N3LPwxc7MJDRPSVMLd7rcV2bQpvgyFw5mvPvu/BZewOlzuCUleoruk8lPQhd
	sWbjjIw==
X-Received: from pgkc23.prod.google.com ([2002:a63:ef57:0:b0:c7e:68a1:910c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:486:b0:3b3:f46:1efa
 with SMTP id adf61e73a8af0-3b328f54678mr25731704637.42.1779905411564; Wed, 27
 May 2026 11:10:11 -0700 (PDT)
Date: Wed, 27 May 2026 11:09:54 -0700
In-Reply-To: <20260518135956.82569-1-ehemily@amazon.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518135956.82569-1-ehemily@amazon.de>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990538854.4123030.2149054954047224360.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Fix ERAPS RAP clear on INVPCID single-context invalidation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Emily Ehlert <ehemily@amazon.de>
Cc: amit.shah@amd.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, nh-open-source@amazon.com, 
	graf@amazon.de, nsaenz@kernel.org, Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Mon, 18 May 2026 13:59:56 +0000, Emily Ehlert wrote:
> Use kvm_register_mark_dirty() instead of kvm_register_is_dirty() to
> actually mark VCPU_EXREG_ERAPS as dirty when emulating
> INVPCID_TYPE_SINGLE_CTXT.  kvm_register_is_dirty() is a read-only
> predicate whose return value is discarded, making the call a no-op.
> Without this fix, a single-context INVPCID will not trigger a RAP clear
> on the next VMRUN, breaking the ERAPS security guarantee.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86: Fix ERAPS RAP clear on INVPCID single-context invalidation
      https://github.com/kvm-x86/linux/commit/b60621c5121c

--
https://github.com/kvm-x86/linux/tree/next
