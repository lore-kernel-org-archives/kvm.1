Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AC730FC26
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161606; cv=none; b=ifJ7viebg8bim9a9S1PppWu/BG22mHJnOGfeMQD2xaCSx26uqdfeNUh43K4e6y6piI14SJGxRrQBPb20hyeiUiDA5Irszc9xdV//D0MxwYxLS+jyvoVyM5vFVLdn5vMc6RHSIFLDE3EVL4ptDLMC+QDTWlkXhKRfMoC9ESCUQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161606; c=relaxed/simple;
	bh=4DYw+Ix5GAjX9NcaEm6lX1l6AjvR1uyssa1w9DS4V/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DG4PFLw+nqeSizuAW1Y7lRrjsAtxecvdc2SJlL0kWG3v4fbnu/UazFkOQ7w1wxvEzxhicWtUynLg2LlHNwIZieA0iOkiOReGHaDx72Ev5JvVjvLLMwJm9qmMgXBku3JV+KWQcInmRiIMGRyKnvRwHiyWL86q3JIs4X7KzMhbCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVnc6NtE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVnc6NtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C1EC19424
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775161605;
	bh=4DYw+Ix5GAjX9NcaEm6lX1l6AjvR1uyssa1w9DS4V/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SVnc6NtEwNl1ukkemdgwNbZgcNlnXaqGr0+KHATvqlNk93DxfT2mGg20rfraieQpi
	 UjjRza9af6spaxsnV2vXFyK6t+WrtopCi5MxTNhgmpptjQtl5fA79949m3CNjpmLGX
	 axKoS5GQSGplnQsx7BToDTQN5vaWmIA1RlFSXwiwKjCrh9GsaG61OirBAHw2UWidYt
	 OlH31Pmqs2VWU42+Lx/fiumqMsjzf9/VLLu7bEcvYVFaxCRliiS0RFB8W4VcGqAt4V
	 AkFD+QmrHkQwyETmMNLxY7J0Bfe2GvY9xc2bxN1fbeVQZYEK18qrrnAQ8E/xZnFQ8F
	 TJhgsO3OXNTzQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66dd0531d01so1998351a12.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 13:26:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwoiaZxaxxf9MVirOLphs9yfGAh5BQW/COVrB2GzfXQPQgXXPf0eWlmv4l5NQHef3y/JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFADPZXHBl1ff2NQgB/7jCiZt1mJTrXO3dgecG34i9bpv5Rwk
	nqlcnGwbD4kzsQR9Wx1mFgUIjiF8QVZhKdqUzdPRTaNp9K4kKOl9p2MVzLtseig6g7nWWLyqwMr
	MNfprcpWwasWo/wrL8ECC/wzrfSRgK+I=
X-Received: by 2002:a17:907:3d51:b0:b94:1d92:7eb with SMTP id
 a640c23a62f3a-b9c67802d69mr14905466b.18.1775161604406; Thu, 02 Apr 2026
 13:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327234023.2659476-2-jmattson@google.com> <202603301501.N2sdlIQ9-lkp@intel.com>
 <CALMp9eSO6gz4R0f1S=E-sA3YE8KE0uJ30otcGsMV1NS3ujUcNA@mail.gmail.com>
In-Reply-To: <CALMp9eSO6gz4R0f1S=E-sA3YE8KE0uJ30otcGsMV1NS3ujUcNA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 2 Apr 2026 13:26:32 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOymT3dV3dDHfhHTM7oawuuzpysWEVgs2-dShZ9BfUo9w@mail.gmail.com>
X-Gm-Features: AQROBzDeel1_OQ9-UKJ3j7R37ZttRLzLFRNbeAQTW_xCWYguBo3oZA-kZDOKmw0
Message-ID: <CAO9r8zOymT3dV3dDHfhHTM7oawuuzpysWEVgs2-dShZ9BfUo9w@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
To: Jim Mattson <jmattson@google.com>
Cc: kernel test robot <lkp@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> It looks like svm.h should include x86.h.
>
> Sean: Do you want me to send a new series?

FWIW, this is the same problem as:
https://lore.kernel.org/kvm/CAO9r8zPuDcHMObfzTQVY-P0Z3kXZbw6y5KJizxvpFWXdW7uKbQ@mail.gmail.com/.
So only the first series that gets picked up will need the fixup.
