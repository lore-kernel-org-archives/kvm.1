Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794217340;
	b=Ulv/jqsu55PrhWSYhhbEBdCEBcSm3HPFc41sHhHWYBYnysHWCE6Y5hCaFPwMrvrCr5cA
	 iURlfn9ErhP75GcHGxI2wyHQy6L5FrizB6Kz7EQsr5n3u3c/nm8AEqcjqZyIWQ+HXhM8i
	 HTpUkIJiQtb6EDY2+L1SJKf0ma/YuqiQ2nN/0Gtdu/6xLBNtLZpleD4LbrxpWKBqJ26X6
	 KkHNBDfOJ/bAmkjT+aPXu4tYPXOSaS8GeOlPtiMxd6tCRli2l9Es6D/JN/AIfL/yKpA6W
	 f6hk5PV9TYIYXn4vg1RhYxJ6FlzNMIOuseuNhc7lS8WRhDdem9gh+crq5nAwIQwPIUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=dnTFqC7NFZ6LKcry7zosB7nFvDvPqEPM5rGL/V6wgTk=;
	b=aY2M5eaByXXO8tTrX5bn3Hy0Q3iYa/pzUARpijaz815xVLGsZgBwuwRn6YS1SGbk2t86
	 C3GAoIUze3NbV/tveyQW84nyRzlcdKgp5zDbcp2kltLJxPSgZAk0aA+StDzejp8Q4MW6O
	 y4YH/8uIttjgmEeYKxVb20dmfGJb0vEfCAPnFw3wzZSJQWJW3kayaFrXk34ha56ZwGjb3
	 vLwtaFhQ9ylHLuTkN0pkqV3+Ir6L/ZTxfzKPCZh8RtNt8VSGdSpjaosX7c0+7ZatICQn8
	 8qJACFWncN2v0cHKiRBRLZkQ+WPFSasKbHdIyW/+wl3olLr3A9g9AZViv+4Y7SYFuEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IW2nD7TB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117B606A326
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 09:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5117B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IW2nD7TB
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so3601e87.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 01:42:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794217338; cv=none;
        d=google.com; s=arc-20260327;
        b=jGLwGALAFMXQirwN07GGX73gDUaFb8oQbAdhe/RweQvRp2n9BS4C/Vog4gH1ImWRjK
         wMkMTEtpVJxEAvvDaMRQzsMYmFcqHj7rt8q/wmI4qzLFNaYN5M5WWJ2b14hWw2sNjuWn
         NSKgF7DFZGo55aIhRvqbDpAm7ej+7XHVHgECpLEXWXsFMY7n5R6m7p2j+nKHHNDpdDpV
         1MMA43B1tGJ5aZZYs+lUaAF8oWqRD0/tXtnupb5zTIPRpWJFouNI67T5VmQGQQawjNce
         phpq/YLmuyzyiF3QYRMmyAc/tgUcpQayk+J+1qImRj0FuxC7rcfxv9w/VIqhjqBCk0nf
         2+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dnTFqC7NFZ6LKcry7zosB7nFvDvPqEPM5rGL/V6wgTk=;
        fh=SbHnu8JtB448oo4w15dOMgQEmImkP4k8rimVoJTHg7c=;
        b=abiGS7CwNRACoi9Uq3o/PpLyZEGzPQwAq8cPcP4LIyRh8uZZ/jRny+GdzRV0ond1xa
         v+SlqWbQlZn9/mNq9BEVlBTIgTCR5vaZVyefRzejU1PjYuxXAlqJSbSzc7HSycGYrJYW
         KgDmJWdfjfac9cQ/MKZ1bwUZLW2+M4XapOfu9+pyetyn3MQzT1S9tO9y3j8xfAoD9h2F
         ZCA5TPz3NxvyCmNUZjb9D7FbboZOOSOdowSNmjEFC06K8Ez55loHZGEtwfbaxem7OYXZ
         YhfbJw8Qpc4nTXsypNkh2kLIMjflsVxOKA57We5ddaE6iUNQH+iiQu+34p8+FQGV+ZJm
         HHBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794217338; x=1794822138; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dnTFqC7NFZ6LKcry7zosB7nFvDvPqEPM5rGL/V6wgTk=;
        b=IW2nD7TBfpylCv/Q4iwboGxtpYLm77TPNHjYntv3vZdOMn07KGEJ8Z+jzF7pqd73le
         R6C3pFcK024lUnAUYKpxEFVxXng9CqVrBsfIHokmvrFogJT4mwvbtoNbjyd3zvhbR9dO
         Tw4VheWTrTOXCPqeGvIvJzC0Z6HIIVEnDDj9Ns+YAcSq1balXLUBN48TiDzLXdzu41kR
         9VnpZtANr8A3VW8NxsBcw0PmQ4QkW8RflYfoiuG3LnC/PhIWHCa6XOWCsah8JQe3bTgn
         Z0femMdJtIO84tqoLbepZiwyEsrNjYhK8lTxSrG6d3YNLh0lwnObvVFb9AYP4xZUrn7u
         1R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217338; x=1794822138;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dnTFqC7NFZ6LKcry7zosB7nFvDvPqEPM5rGL/V6wgTk=;
        b=K8QNdbrJNAONGqW3Q0esQUFuISKbALhhjZp9bnr2r/IQ1XIL1xiEZmensJkqqFfed8
         D3I8mwwjBgAjMUi3XXsuK3Pje0WdYLN94GlBXHomYr3SOSZ0VzVyFgWHDfUB03SqCrDA
         ytE8AqTw1KSJFxNNPW7HBRDex8fH/1u37isCqxrWvpteVLvnmmuEoASxyBR+a17DzZsw
         nfK0YwmzfyIGEAE7yC5JIltCfrVBgCaTNNV6Gp57OsqXFYdQjKR2Fc7hSB8DaZ6voLVv
         zwGSG6jz2+4xBH3PTMpWGPPPUxHGsHpg3zQw0Uz4RhvyEX7geWgWb+15wOAvEERHncrM
         6j9w==
X-Forwarded-Encrypted: i=1; AL+hErEl+u91hlTqm0DVzD7fHQKhS54TtS9d49a9n5hrLuaYW2mgLdTjfnU5+FSH5t+hvJn2ozk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V6D/h3EvkwGHO6AcGPKHLs9IUS86/FJxNsLBmeaGqvzOzqlpB
	WwvWkwEkHEtao6ZnySOLfSapkokZMyfWUKi3Xsmxwn04jUayFxtosUFfWHKlFuC3rV0V6yRoTNm
	XCx++uXG5cJGkMeP4dNsO3PfRolHC+JuXUSh5hgALN3O5qIxAeJiU6qXbO/4=
X-Gm-Gg: AYBFou1ZEpqJDmm96vB8ZYpInIow044/OrVBwq0WcQY0oIamSNAaZRxrb9Zj5LLTn2G
	LuUvZG/2O++RSgWK+6gn4Yuo7OqrYkrcFuXKDbmBwYVJwbES6vb769udxZLUNBfC7llGBNk8Wra
	ddDY+0AqB/9/rGprFIY939gThxPNxu1mdwKAbkYPsenyxAA1eVTorYegXq5W3MKC69zXR3Db7Vp
	0si1wA1X8cju/QguiXOaLiT1WNlyoCn7x94SJvr0oJhlkxeeSaKfyXDlrB+QGi+hxoA5giR1CUS
	flkRN10Z/DEz5maHZ1XzvBmBAQl0GEbaiGtOyh3RhimhtbXqY7saL4uD72toCU4OgYLCJGuE8LA
	+M6CWxb+7A5+CWItBX5pa3mjDByDaqb2KcVKRRjGV7z29uyoRfth6sjAbO33/geSYpfi7JRBggq
	3Apo3Pzp9dmUh9jr4M2MjPZJ7K1aG1EjUsyJc/iDj5jX9U4U4=
X-Received: by 2002:a05:6512:304c:b0:5bf:f81a:f24e with SMTP id
 2adb3069b0e04-5c00bd5bc9cmr144934e87.10.1794217337930; Mon, 09 Nov 2026
 01:42:17 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260922071945.693714-1-fuad.tabba@linux.dev> <20261007074037.316564-1-fuad.tabba@linux.dev>
In-Reply-To: <20261007074037.316564-1-fuad.tabba@linux.dev>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 9 Nov 2026 09:41:41 +0000
X-Gm-Features: AclHuK_MaYET6PTkt0ZnvA66k0DV_1M55e3jB2HzY2bpxHczb0VPvo1hIAKLqfY
Message-ID: <CA+EHjTzaJx2nV_9YEExgYn7STSP1Kvhsqan8va8M7ba4WtCiqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] KVM: selftests: Fix incremental build dependencies
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	James Houghton <jthoughton@google.com>, Will Deacon <will@kernel.org>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean, Paolo,

Another gentle ping on this series. Is there anything else you'd like
to see before it goes in?

Cheers,
/fuad
