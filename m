Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F991444709
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229893; cv=pass; b=W6wzZt/bm1OlkvCfqSbXzS+/S8H+tNw8zIvXHTBPa1/q4uHHYm2pzFVRTRbQmJ9P0+yn3ysBZa9a9YNAcLwMlvHfF+CP+Gh25gDi5mXBeTh5cwNBdXjmelEZId0tzIPOzHXtYv7QrVjMO5YLLfCGL4q7N3sjB9RJxwHN++dOhR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229893; c=relaxed/simple;
	bh=jyI+Vm3mGeNC+CYypb2gorBot+HaAXIcwYJlcWBJM88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaV6ofhn8mHxxywPJesttNp3/2SqQm8UAgLTsR1s1cFdbof6RC5OT6FYBtwUKMnrcwCGvaMvcKlGX/fw2Y90BgZvWOcGWy8IytCzXa+spLC5wtYiVAAoi/hPnYnWfOGOsVbIHShU/VwHBEBAUQgaaTD5ic1o//6MoWVDhVxQOBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAxyWhTW; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAxyWhTW"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b153aa3e7eso130915eaf.2
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 05:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229891; cv=none;
        d=google.com; s=arc-20260327;
        b=L0OgcyreJ0yUIQRYAR7mYbf25ZyraWeD1I6Zgrzbu4b32VwwchfSUkf6m2LBw4/nQ+
         GbfgYehbHpz4o6/0MVN/a3YcLIGHILtoJeIcyEEihv5OdfoaCgRe0a1YtR7KBxSbKf+k
         K9p44BB31eTOHUT+mZomJbGEumA9wYXAKM5mDteGagBa2MOF2jeS0Zu+i/fDKPiyrGqQ
         yKqBdUKIzNv2oYKLTDzLPQ4mon4jnJY/Q0H7DB/S2ddxLUeFL7tQt//I54ioYDan1yRV
         tN54c0hczzeEqAusTeiA3Ay0jqtB14FNSjXurFrrF8RXo34dkCyjY7ytAw8k/WyOLZxV
         AaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1ewQsjrB3dWw2WCSzqA3m0QcXJPMHvYJmkQZlqFZeQA=;
        fh=mOEbM5TcZZMHicKBsKePUzGbQBsUD4AnUkQmH74fhHI=;
        b=sWOVLsp6C1UC2pYpy4XSjUIXGqKUa6Le41tIIF0ltqi9F0P6gQRwqak6gbfQESlhfz
         lCxHQLWsswM2i+GkndAXPM9rNc7m/m+q3gqfm+pbHi9V3Rbirqgg1TTItdIUPr7+11te
         sPsBh6Xx+pMQG0QJ30+92L0grbB3sEIP2yKuYYlpZwwDjpS62FaHX7q+jV6dshpZNWPc
         CmUCeeL+EEVC5IRr+eKJt1HQvEfP/pjMKmjL4BG/iwor2EDtBuMk7leBz8f38zg2pUXu
         FKbFOwLGq9/ilM/VvuZ2EdDiTPNshJBdNZMCabTX8IOMcRNbcG1aEBm8yAVJokhW5IfC
         YSQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787229891; x=1787834691; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ewQsjrB3dWw2WCSzqA3m0QcXJPMHvYJmkQZlqFZeQA=;
        b=MAxyWhTWaK/Or5g1GbgjRdGn0s3+0ii7LnNjyIU8frtugWY/3VKtMVebgMVzEDerpq
         7EJ/Qj91cr+c7sJR9gpJtatdTeicAshfV+fWmKH8dp8dTarm6bjWXDIctUuuD1UyiiBs
         JeM+aJ9Xi+aQ5cK8RhNdp+v6PRSDqIDYuGBfJZBwL08U7Rb4wSCNddOIal+DDM1HzB+/
         h3ljUkBPNhGL5o8NBLQyK/aHfSIiO9qZup9v3R8ZdsZMUWcb+h2WjhV6gkd374l7mmyM
         qLmkO/lDetA82B1NA/JiVEZ3K6Jo87kv/JDgi6FB+07e3bcp4BzVZ1NRcWpAafbGpeEV
         Vdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229891; x=1787834691;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1ewQsjrB3dWw2WCSzqA3m0QcXJPMHvYJmkQZlqFZeQA=;
        b=OmKqzGfR+zm7xx3wx2A4AuOCdr2LHAZelMST176IgPy4GpQKOtM8F/2v7yqVKpS/VK
         CZoqw+1YKd83Vui6CJ6NXIvY1bx9kbiLH68lARYTbgNDk2ZPeJX6/ysffYsQgYABa1KC
         3QzyV7IfZcFd7MlL8rWUsvwExJKZiEUP1gl4JnB28g0f4J/DL438RpFdDWsHGKDW42/O
         FRssZxnZyS1wzG4zsbS7l0ZYFb0nYRxii8Wg8/X1YA8ayCGmr63U4tlr3+lg5ePuJzA0
         F7+C8fiKwUccCgj0ZwwWbSwO3wQzbzNqqqeyxqn1tlrfrGtxPLcuBot0b7saOMgO3+dW
         FWGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqP15rhH9wgPmcypvxgMA/KCtUyaP6eO6fc2oLd0rXNDXzxeJRRg71OKkb6+Buvtxl2tZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDaNSTP89jSBPhlme/U4YzmZNbQeQNEF2uRErSRVunJRt0TIh
	7RH/9fwr6BSZjDDia1BHU5pU3X/IvUpXgjBjuBLtzqD8W411FVtMujHd6TSSDp/4lpkk4ZwGr4B
	KKSKylEzYZmyNCCD88ox/rEs1upvBPg0=
X-Gm-Gg: AR+sD13DKQgp9XyX4Dxje207q7leA6InKVKONP9bawS5GlKi2bGQCcfi31kqazJjH2k
	byIbpz8uk2XlxcCe+F35ZBNAVlNIU0Q+ICrOF79nVttCMLAnDWXl6LrWZFHtr5pgwTCFuPbujXS
	RXYRNPAojuXJWpquQ94F1A8GEBWmDiwdA4QBEhUXcLqmHCmRiJQ4zxjtLCk2gFnRPQLCdzzM64D
	725ajbA1j+4FImIPS1M+6dpXjP8gw9Qvjv4r2iy+kuIV1K9pz9/GvYRerUf2WlbKIhdF3J3cw8J
	y/GJYSMzsJHNMSld6n8TGoX/X8nL9M3YTxNVqJemXkbsdXRseZdpp9xvNSV1MElOFjY=
X-Received: by 2002:a05:6820:826:b0:6ae:4131:98c6 with SMTP id
 006d021491bc7-6b13c2b6003mr9891957eaf.2.1787229890930; Thu, 20 Aug 2026
 05:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820123512.87236-1-duankeqiangcym@gmail.com>
In-Reply-To: <20260820123512.87236-1-duankeqiangcym@gmail.com>
From: keqiang duan <duankeqiangcym@gmail.com>
Date: Thu, 20 Aug 2026 20:44:38 +0800
X-Gm-Features: AcwNN1Wteh1s9B-jT-2PK7E4lRkFjXUss76ZtEM0zUoP7x-mJc2sfkp-dbD64ng
Message-ID: <CAMd06XfsK+X1xVX7=nW+U572OxnZp1vFyYjBNdr2AMtb2zgYXg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace
 makes a vCPU not-halted
To: seanjc@google.com
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Qinguang Chen <chenqinguang@kuaishou.com>, 
	Zhiping Du <duzhiping@kuaishou.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"

+Cc Chao Gao

Sorry for the missed Cc.  The patch is at

https://lore.kernel.org/kvm/20260820123512.87236-1-duankeqiangcym@gmail.com/
