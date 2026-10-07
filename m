Received: from mta1.migadu.com (out-124.mta1.migadu.com [95.215.58.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE16A38236E
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355568; cv=none; b=lYSjiM7eUsX1N3AQI/YDpLC4HiA1cJf7LebaWRGGrNl7qf/NIFM2vsZELtPwj/tJYLP+j6uDpOfZLEvEncaUElRHGJd76EDKDv2ADQaY3OOKwk8Ryxy++LQSEnYG0cL3L6Rxd8XwyXCMyX8OjCFQg0p7N1OVlTVcJ4bCz4tOADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355568; c=relaxed/simple;
	bh=nWznkk9Fjq/D6EuRqmF/M6hW1RRZAYuOo1VRXMA0j/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dK7x6hiccPn+pFbHFGstgWtXd3LStE/bC1wVv89QMPUWs3VLt/svpurPZcY2Z546jZNYNCJXXuw0IOFWW5xUeQtufjqNQ51gGbVK9RbMAFYWi6n2vXgcC0g5CZ5phIgYkeMuhgOc3h+gvNCI8U0ClGz4+wcrw+oTLUeIZQ/rRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nn/CcGF+; arc=none smtp.client-ip=95.215.58.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nn/CcGF+"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nWznkk9Fjq/D6EuRqmF/M6hW1RRZAYuOo1VRXMA0j/o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791355564; v=1; x=1791960364;
 b=nn/CcGF+I3KFMreV3TXcBHgVTzBEeQjbT4YyHkH5WM6WTWmwTI4CX03cFl+ldfBpRqpENzfi
 78XwCmAOsLy3Y1ygtWYA8NQqn3cokizL2j21AGikdW0cZBbTNry9CKSV2tqmYSNKHTkzw2jd2fu
 nKa9iRLCMeRwjFlPD4bUKhVI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 59b6b061ec4d7f2b;
	Wed, 07 Oct 2026 03:24:20 +0000
X-Mizu-Trace-ID: 59b6b061ec4d7f2b
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcc04c71f5so4645e87.0
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 20:24:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzDBe2+0KAYBWomwwg7vhuBLCplr9yItBAcdiuFRmxTJ+JOxboOKI004mH/wKIQRoLtWRk=@vger.kernel.org
X-Gm-Message-State: AFq9FYISe1+m8aQz8Pn4DdoKDFA6qSAvHbnIKPl8l4NaElGs1gvP88JU
	6jznWWFSZDFHUHwrmJwobJdGv+kkFdQLDIG/lhl5G27QP+gOq1MOAnejEIbSddY/dFua4rT4AK0
	81sPR47PzBXWcjcA5TYuf+4dX+0EfC9zKZQCidFed
X-Received: by 2002:a05:6512:33d3:b0:5bb:ff6f:b4bd with SMTP id
 2adb3069b0e04-5bcca66e395mr244231e87.14.1791343458771; Tue, 06 Oct 2026
 20:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915084441.3846947-1-fuad.tabba@linux.dev>
In-Reply-To: <20260915084441.3846947-1-fuad.tabba@linux.dev>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 7 Oct 2026 05:23:42 +0200
X-Gmail-Original-Message-ID: <CA+EHjTwqmQrLz5aDsCo1JFE2H6mz_dWDf=fkLsNup0cgenMCbg@mail.gmail.com>
X-Gm-Features: AclHuK_KSLUhfLp6Pl2z-XBsxbeEyfCpN3TL9UgSgX_CqN7OtwApebc1PcGPn3k
Message-ID: <CA+EHjTwqmQrLz5aDsCo1JFE2H6mz_dWDf=fkLsNup0cgenMCbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: Replace VCPU_RUN with KVM_RUN in comments and docs
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Gentle ping on this series.

Cheers,
/fuad
