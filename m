Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D547ACD0;
	Fri,  2 Oct 2026 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939695; cv=none; b=hRJd8zQ+gjkVc52dSwSzIeyw15jwf8zzhJe+pW46dhudeA4UR5iYAVreQG9HJ/IjNeBLKGLxjcBrJo82+RsiGpH6RLoV20jQNnnPD6zIZ0/Z4GEBBQLBY3fFlxZBjIhdKmo+t7Cz8ztZ5DIRqxcA/EvdC86xamxWSJhRGiRKOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939695; c=relaxed/simple;
	bh=AHV6GqfcQkNE50jwqkl3c6c+aR1aTKotUJBs2VFir8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=e9zmcblHu1NyRV1tZDVN20NjPp202tGQkI7FjMXCk2QtCozG72ej1DShvfyUZGRI59WXZCW+x1zIcWKoYNczWVoPao3W/JrcSvbSxt+FOaLUoUOTVXOZXuyl3ud4A7+k8FydqYAkad/2Dcj+jBPJktNp/qxjVEZvtkO/lAM9yak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X9jmQKAV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X9jmQKAV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EF44497;
	Fri,  2 Oct 2026 04:14:49 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 362693F85F;
	Fri,  2 Oct 2026 04:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790939692; bh=AHV6GqfcQkNE50jwqkl3c6c+aR1aTKotUJBs2VFir8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9jmQKAVzRfRHkywLZv8lcNL/IaeYIMgScnpocagAoyrOkVEsqRTxf9UfadP9w3El
	 Hk/vcsbM98qqvEaYVJHIEGhWr8ToUL/lSN8flesU53n3XqcaMUQZ8K1JrPFKKObKzN
	 8MH4Y2l6m8W9AQBm7On7/Dib0IptG8Wv8ttdQZeo=
From: Leonardo Bras <leo.bras@arm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Leonardo Bras <leo.bras@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Josh Hilke <jrhilke@google.com>,
	Oliver Upton <oupton@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] KVM: selftests: Check dirty-ring size before enabling
Date: Fri,  2 Oct 2026 12:14:49 +0100
Message-ID: <ar-SKLFC1gxQ5_aB@LeoBrasDK>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ar7qS3PeV_zo93iT@google.com>
References: <20260929113711.2064390-1-leo.bras@arm.com> <20260929113711.2064390-3-leo.bras@arm.com> <ar1xne00AHnJ-p_d@google.com> <ar5yW30S75THCfdV@LeoBrasDK> <ar7qS3PeV_zo93iT@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 01, 2026 at 04:18:35PM -0700, Sean Christopherson wrote:
> On Thu, Oct 01, 2026, Leonardo Bras wrote:
> > On Wed, Sep 30, 2026 at 01:31:25PM -0700, Sean Christopherson wrote:
> > > > "Dirty-ring not supported in this kernel\n");
> > > 
> > > "this kernel" could be misleading, some architectures simply don't support the
> > > dirty ring.
> 
> Hmm, the counter argument is that this is actually accurate if those architectures
> were to gain support in the future, but someone ran this on an older kernel...
> 
> > So, do you suggest keeping it simple by printing "Dirty-ring not supported"?
> 
> Yeah, unless you have a better idea.  Actually, even though Kconfig isn't user-
> controllable, it's still there in the .config.  So maybe something like this?
> 
> 	TEST_ASSERT(cap, "Dirty-ring not supported, check CONFIG_HAVE_KVM_DIRTY_RING?");
> 
> That would at least give the user a breadcrumb to start with.

Yeah, that looks better.

Thanks!
Leo
