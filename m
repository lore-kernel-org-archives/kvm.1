Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FB477981
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574352; cv=none; b=WMxo5Rl6su3f1fbbjA1Ewsqkz2j9EmthkSn7TgRqky7uLnmNDLuGS0Kt7dIhYfTLGJspeaofXKOBoCNApQbN2j+SdmsqbjzSx04Z6JEyQN7B5Jf76XPZ37HLUrQcw7YzHNDzuRqaa06Lyza++DQwxhKi/jYd9Gn0iNQb9GUvtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574352; c=relaxed/simple;
	bh=iOsVMzT/8Cb39GRcd7ATjSzKWR4W7omMcN6KM16n30Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mdMWDNmNDfS86+svRa+10X27KcY1w4+5YJAiVnwBjnpRGVz+qzOWLXUW8fsJEiJeY3dWVpIJjCYEjyTSKU4pYIi6p9fugT3oavRaAAawn7FtMN2YbI2Ys8ydBXqH/EbpIEdfMTM/fKC/S7brpHkWOYABNYwgtr+jkklalnDEJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1BewXv8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1BewXv8"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7976ded5c5so1290175a12.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777574351; x=1778179151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7xaACyRgyd6PGfInkIxxIhlW6mYgGJvMMxqUZPvr3I=;
        b=q1BewXv8QrnuWJtiNQ0FDl1hCGLnADK1LOzuanQ/9XmsSHkKsAawoKh6Ip36zDhdwE
         4esOI0RIGbBu3voRDX7b6kko9rtTRccVhm09VSzya4mvEGvc9WNM6+QVeJmg2rFJBxZT
         2PpvG98Wbvej9Y6vgtWY5GEzk+87UOQ58XuwzOkw1l7P8Sc9gMIyYoT9uBrIsBHwQoWp
         wVsxGuD+KKn7S6tedk6YzkB+fRdG+UOJV65w98Q6Qbim0ck1uHyvNMH2EQ6Sps1MMYEY
         NhBt7AgYmz/xtTxFjP1jRYWPQ3v2MoE9R16qQpR7iAaUmROKk/aRhzcAwRQiMj42Zkcc
         zYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574351; x=1778179151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7xaACyRgyd6PGfInkIxxIhlW6mYgGJvMMxqUZPvr3I=;
        b=CyWFsmGB7Ph1nh2Wq4CIAbGPI13tVaSW+7vHxEeV+zMrfF1IMMxBJUE0rNfPyeAgQb
         n7z3IafpRjqAYN4qWW0EnNJvp+X4u2QE933VrbqgOcd3IMzzLF0w3c7OExkiEBIW+QRJ
         CDvpOHeT8/i+Zxgdc7Qio/gv5KzG5MU61hcxZtkD0sYY59qaR8vcN9xEOYsyPjVG+STe
         rijA11oEefJLrllJOKNrKvelSn7aJnjdssrHgPfznbIBIgCCC7wUETo1lcu0jeBnnFMC
         c1+JYCuXmJ8hIbig24eclwYLR8/2E4pC5LoaaFBnJ/KsIG2g23/rU7p4iEnJ+sswEnm1
         x7Eg==
X-Forwarded-Encrypted: i=1; AFNElJ8jDUFekbI4fuv4w/Q9DVq0RATs2dPJ4W9/YqAqo4PrfrCb3omCQOBCGxo2d5FiAaxPOOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWC9hcYWEVA3ECa2R7lCKg15C0FJBjfywll1FULyNNczQRhXBz
	0qmdlT6pNfUs1NEEbKoTBQtvIEbkYezipvXkQ3gnezA/nCDgkrTJ6dsDhixtuSjjZ0QuAkJd9gw
	kUxa6Wg==
X-Received: from pgnp28.prod.google.com ([2002:a63:7f5c:0:b0:c79:5fb7:acae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:328e:b0:39b:c4cd:d854
 with SMTP id adf61e73a8af0-3a3cf7ca9f1mr5026514637.30.1777574350744; Thu, 30
 Apr 2026 11:39:10 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:39:09 -0700
In-Reply-To: <20260430150747.76749-8-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-8-pbonzini@redhat.com>
Message-ID: <afOhzbHeUzISCCx6@google.com>
Subject: Re: [PATCH 07/28] KVM: x86/mmu: rename and clarify BYTE_MASK
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> The BYTE_MASK macro is the central point of the black magic
> in update_permission_bitmask().  Rename it to something
> that relates to how it is used, and add a comment explaining
> how it works.
> 
> Using shifts instead of powers of two was actually suggested by
> David Hildenbrand back in 2017 for clarity[1] but I evidently
> forgot his suggestion when applying to kvm.git.

Never underestimate your love for decimal-based bitmasks :-)

>  static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
>  {
>  	unsigned byte;

Rename this as well?  It's "fine" here, but it gets quite awkward when
"KVM: x86/mmu: introduce ACC_READ_MASK" makes permissions[] an array of shorts,
not bytes.

No idea what to call it...
