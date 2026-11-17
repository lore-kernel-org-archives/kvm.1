Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946048;
	b=K5YnNZlPr4iV9JO1maaRfAPzBnUmNPj5iXBXeVrSgIlWJx3vHwOf5M/uXkdCtpm4uLaa
	 3ORK1KPy1PHr0HZx8YVJ0eLsHA3RZxSnLvx/bevahOerYhRlasWDbWY8emmMErH/DJFqo
	 1YgH2W4eM/RgUG5EvtagqfHDvg+BBYM5dTsWe0rmLqWcBUKLUbUyVJydjovZL1uHQU1vh
	 lIS6fwo0ygJK/NtKS9IbUw4cJzCf6AqyOThs6Enkrikbh3XLoo3vEMQmZ5wP0f6v4p6bP
	 AkAmJTFZb/fMvc5VSh2O9AQ7EOlIrz84NE6mvs01mfEfH2jWOygP6PtP4t7vbzRxz2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946048;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+l2nFOsAmq1gZHsAi6Z4cxsNprGDpMXtJF+9rJZ8MBo=;
	b=x+OZB0okzO08UTRnRmGTIGHb5BlLl32KckCXcIbuxDaQPpwA4a2WsisP2UZrA5j9BSvL
	 mpncx/rYAhKClYxZXsyLIMxQOhnMvhUtuSVvDclSsq9B576q96y+5uF0GPSEW5NOATW6f
	 uphOBitLSNO2lw0I210bYP3r0lnjd9nSqZ4E1FNGjlM/1HoO88rwXPCk5fabiVXgil1Q7
	 QGC6leQ3JBLdym7s3NOkOhd0pXpcyq+X/fdMZOoUajIdhMT8KktIgQGaX1mwTCvi9H26k
	 QAi7B82yRN2ItrophJZ0VK0cW9JpDiRojz4xl54M4bMH2FWdo9N0pFZnEOhP/a07RMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NU2x4urY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0EF606A883;
	Tue, 17 Nov 2026 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NU2x4urY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D59D1F000C9;
	Tue, 17 Nov 2026 20:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946047;
	bh=+l2nFOsAmq1gZHsAi6Z4cxsNprGDpMXtJF+9rJZ8MBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NU2x4urYrebqPQD8z1Dk6eNi478RL6tiDyFGlMgru2sxSgo6R1QCJDb16vRj5PhBe
	 E1EfgeCk/zf0jYHNKISzJ/OVAurf2vH+Dx4JrlBiGJN+3MOJHX6ueMDUlG7+FhEEla
	 L3P4yZ4KNiXcGgYLHfwrnvjpe5z0XhMcrXWIpEAJLautOFGalCATiN9qoMIf3BtkrN
	 TYMTkqS8KAZi2RerKNoZ094BLfCIrOuGvkQGPb2oCuMC8pUee/TNJxnJ8k1p828ZH8
	 i83fxNTkWrFYp0WBidZNdwtSCMVJYjjF68LJiCFHMFkRBHbHCsBBZVyhVR9ZO4Jo6Q
	 4L80UtJUenHEQ==
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] KVM: SEV: never retry after #NPF on paging structures
Date: Tue, 17 Nov 2026 15:07:26 -0500
Message-ID: <20261117200726.2421132-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117185922.466255-1-pbonzini@redhat.com>
References: <20261117185922.466255-1-pbonzini@redhat.com>
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

On Tue, Nov 17, 2026 at 07:59:22PM +0100, Paolo Bonzini wrote:
> +	error_code = svm->vmcb->control.exit_info_1;
> +	if (error_code & PFERR_GUEST_PAGE_MASK)
> +		goto resume_guest;

The subject says "never retry", but resume_guest returns
X86EMUL_RETRY_INSTR, so this does retry: the guest is resumed and the
instruction runs again.

In your reply to my patch you had X86EMUL_UNHANDLEABLE here instead:

  https://lore.kernel.org/r/7b4beea2-2bc9-44d8-be6a-ecfe678091dc@redhat.com

Which one did you mean? If it's the retry, the subject probably wants to
say "never emulate".

-- 
Thanks,
Sasha
