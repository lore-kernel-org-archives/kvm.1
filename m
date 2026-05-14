Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64923CF977
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797732; cv=none; b=l15FYAaNvtoF1MuxPpuZrvr1xtoyKZdg5mj3mkSAPzy5L7XnDlc6Uk8LnARTpT5MNd3CD1gs/EJ1qny2ee1VuudyBwIWbbJfP5mjrKtwE/CaEOEDypAJ1g0XXmZtXlWyEx5gFzk3/O9V2j2dviciMrCw9+C7XO41KqIvrmRlgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797732; c=relaxed/simple;
	bh=HRhPlO0ziSt7HvWcU6JXMkPPMAT6n71LQ3NhrLkz2+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJHwouT6c3TcueAowrlWsPO1KylPasF6HW/DqYRFIXJQrhsgbgwgOaA/OxGUXQ65CmwvOdmlqVl41b/EYU78GF25uS5gxeE6IcuzUatllqFW7ril5yPyaVIoTQntWEZs9vZkgbsnmBsqANkXfcYDb4OXcewsnggoeyafzsBMv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja9kSwJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja9kSwJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78452C2BCB3
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778797732;
	bh=HRhPlO0ziSt7HvWcU6JXMkPPMAT6n71LQ3NhrLkz2+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ja9kSwJW/DHZ7qACvnhUh9XFsVFHkuNfRbHxpkQFhM2UOopjWfD7u91rvJ18/fZ2u
	 y5p1fyHMQePx0HyuefoIKTvuWpKu8xe6u7xXRKmvnqxyzkwucFl61CrHVnWI4h3UFK
	 a2gZy0oanhdr17e5osAimnTsvGRcKKpLMHzDDSIt0HKd1Y6QF+bfeUkWbPbz8BRl9Y
	 v5CYW/KaHpwmQxTv8YDr0mJjMVT8+i1aPl0GS6YJpzUxTVR4Rn7UoYtE6Mu+himZIC
	 e7U1Qn8fLDS49SgTUejOSA1VkijumlidCYg6oiu9UvbBREnlKhQghvmST4yQM2DCEX
	 NHqw2aUYreN8g==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd11a3729e8so704230666b.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 15:28:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+7Aok8tdaj6AjoHxTxWagMUXorKSvxYwNJjS+vsSbCINdhrK7CoFCunaMJAyhw98mZS+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmPos5EsiRvNrUvtdzWi87zLy7tNoKDxWN4SnEyeXQyjMFqhY
	0h+X6IfoAj8rmxJhI8my1KctZiEb/FKTgQYwxrhvx+esaRES983kAuFGSjSnKysweDoY0zOV8g7
	FBtfLNRdnHCHKivmxV+PxcwFpvv1AsuQ=
X-Received: by 2002:a17:907:84d:b0:bd2:124c:c5d0 with SMTP id
 a640c23a62f3a-bd517990c29mr55087766b.42.1778797731369; Thu, 14 May 2026
 15:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com> <20260514215355.1648463-7-seanjc@google.com>
In-Reply-To: <20260514215355.1648463-7-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 14 May 2026 15:28:40 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO-g+w2WxngjRaQCDAFk7k5dV2tL97eJ8YA1BPOzS05nw@mail.gmail.com>
X-Gm-Features: AVHnY4JyFs13MFByCiQOkGH8KHdFY7lHHsZD5kvgUzRDxJmsE53VF--h343JASg
Message-ID: <CAO9r8zO-g+w2WxngjRaQCDAFk7k5dV2tL97eJ8YA1BPOzS05nw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] KVM: x86: Rename kvm_cache_regs.h => regs.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 2:54=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Rename kvm_cache_regs.h to simply regs.h, as the "cache" nomenclature is
> already a lie (the file deals with state/registers that aren't cached per
> se), and so that more code/functionality can be landed in the header
> without making it a truly horrible misnomer.
>
> Deliberately drop the kvm_ prefix/namespace to align with other "local"
> headers, and to further differentiate regs.h from the public/global
> arch/x86/include/asm/kvm_vcpu_regs.h, which sadly needs to stay in asm/
> so that the number of registers can be referenced by kvm_vcpu_arch.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
