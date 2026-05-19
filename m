Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE83BB68B
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226021; cv=none; b=BGV7vo2i+4Zxrnmu42KwQ5t1AKX8q8UQp8DrSASarC41RRicfMZIw6mtWI5igKFfhbLC05W/bkR0m3/ZDVJSYZpk8q+gJGDRdx0z7E66uXoYHiqchMCldSM55QknR+zf6Eo306UsS0Ra75vyQso1Z/4r91eNZFg7Eiv6L+XdAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226021; c=relaxed/simple;
	bh=QW98c0EO5p8OfysXhROXrzCpSjihaq1a/XqjsKWTkuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rjc+rNp8sCIpwy+ia5RXse7ajw5vzxW7+G++sgdpb/nXVMfba/QHolCo+uBpEuZTaTYcjUyR2v3klVL1qOSTwa29ZJIwuj0Kq0dh7XkyipL5rPIc7ceg7P44KInygP7FKT0hOhIn7IT5dQK3iWU5aiMRnXdm6PIyefSUIpWC+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQI9NLVa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQI9NLVa"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso41695775ad.3
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 14:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779226019; x=1779830819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdKp/MEfbZ+KU36s0cohlMKlKnHoAQty64EupqgsQ/s=;
        b=LQI9NLVa1rJpcfzHT8M2Z8KArLcqGKIIHJeUoRuWdjP9yg8IGpJiDQ/+UyHYqrHqOm
         53YofhIiWprj1Ge193KZDji/6VFVaX7SAIMwy0dNX6GgNLrtt2TTQgG1QgudHjVYTVMg
         XQC7VksqAAUGMP9WUTee/wbJSa+dtCNsP+lUjy4Cn5ibfrjU9rqAWmGVE73hNv+XNGqp
         VnTXX37wiVIY9TxLx0anpdW+n5XDykswPRI+pySAWXkQVLDX8weVlgZRCPsN8Ly+wo6V
         EkIgKUtt8MnnchdBlKFrZWbLlkKd2AJGSb23scglWL1rW74W66/wtIIdNgw8ydfg8hxv
         DlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779226019; x=1779830819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdKp/MEfbZ+KU36s0cohlMKlKnHoAQty64EupqgsQ/s=;
        b=NPhQ44Vsl4w+G2HtSUWGJQg1MMDtCY4OknBXwVwE/MrAvXvjd7grGak5QvvqsaBG1d
         UDtYX3TnANqtbyO7DIz0tdVrxooTiNjl9G0FMOtZJshblsZJw3QacaynY+emNcCOpVlR
         SdBbAEJcSaalv7xD/swa5srWn3be//av8L9uQ8bvZHiWn06pd5093nMaMBVKcwUe8CSd
         RByQwixEx6myu/wdeSd3wfWzWKywiIVKgwPQFsxCW3z6ZoOVRbUyrRaHSyR5gFr/j34V
         EfWp90GoHsWlTSN9YFjz1M9JHAPy75jzjrIWJOoOKWJQIvGq18RcGsZ1u/bwDfqpmmln
         aUjw==
X-Forwarded-Encrypted: i=1; AFNElJ+cwK99WVT+Ecc5SCR8e1cRW0cybUN9oxM419JWcGZDxKY2pKse3faIZbI795y7OplpISA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymbPn4XpG9h9fVVSBL6ZwC4LWeV/JgpopweiM1lfMusYvwv9F2
	ysf5CQeoMnls6+s9saU/3xD2vsasE/YCwQJUXNvew80WxMyGa2idOU9s+hlp2dWhwL4D5rPz3Eu
	N6GWs4w==
X-Received: from plcl4.prod.google.com ([2002:a17:902:e2c4:b0:2b2:c88b:31b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da90:b0:2bd:612b:912d
 with SMTP id d9443c01a7336-2bd7e8ad548mr220905995ad.14.1779226019010; Tue, 19
 May 2026 14:26:59 -0700 (PDT)
Date: Tue, 19 May 2026 14:26:58 -0700
In-Reply-To: <20260519202851.1339906-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519202851.1339906-1-arnd@kernel.org>
Message-ID: <agzVorbOnlwczjP-@google.com>
Subject: Re: [PATCH] KVM, SEV: fix merge conflict
From: Sean Christopherson <seanjc@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Alex Williamson <alex@shazbot.org>, Steffen Eiden <seiden@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Liam Merwick <liam.merwick@oracle.com>, Michael Roth <michael.roth@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 19, 2026, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A conflict between two patches leads to build failure for
> the reference countingg in 'struct kvm', which moved into
> the kvm_refcount structure:
> 
> arch/x86/kvm/svm/sev.c: In function 'kvm_lockdep_assert_sev_lock_held':
> arch/x86/kvm/svm/sev.c:118:32: error: 'struct kvm' has no member named 'users_count'
>   118 |         if (!refcount_read(&kvm->users_count))
> 
> Resolve this by changing the added reference the same way as
> the other ones.
> 
> Fixes: 422c363f58a8 ("KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio")

This isn't a merge conflict, it's a bug in wherever this commit is coming from.

> Fixes: ba903f738249 ("KVM: SEV: Assert that kvm->lock is held when querying SEV+ support")

Because this commit has been in Linus' tree since 7.1-rc1.
