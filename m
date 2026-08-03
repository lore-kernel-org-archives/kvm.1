Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFA3C8C48
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800910; cv=pass; b=OtgWnR8wVkVdNwjtrJX4OwKccVMP2+DT/31za/ZDsxe5Nb6v/4wwCvAD8gii7dLoqbPk1BmcWE7h8xlFakhMNy8qL3hLQEUOh/lxEyjGiq3vNB0WjjSJ8cbxihdXtRgHIIu3ki5U3bvkC3Q6sytjL5UK+iJ0R7A8YPUdFEY0xBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800910; c=relaxed/simple;
	bh=OaNo3+m2t1WoDUpnIrKVbq1gRB1KaWUBA+5ABnBBlzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV8xlqO4siElxJQ/yey78JyYFOAB3wsrwNSEU+zDKtbxOPPCo3/lRidzuTjt25nCAFfi04YoYIkq7lYzaHx4WKwv32ESvnJekHhrSPXkzi1CDz3K3pNY5y6cM4zI9MNtfIjPgQi5bXdLdBx2m01Le6uQrFAZGbmNNwrI3XDghos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQdUe/6O; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQdUe/6O"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so5903a12.0
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 16:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785800901; cv=none;
        d=google.com; s=arc-20260327;
        b=jmdzCYCE8LOGehBW8+tAK6vLBVzEpcrE49SCpzb9ckfhx/kyjr6MW3qrc4uQaJP/vd
         5qtAlAECEhfFlXwot4FhuoxdNRZFV/Qn7TNPHwv8eRNh6X0cRjeU7O734z3MrxDZrWRJ
         W8HRcyNnykKyOu6YZWAr/WMdGTym93IJmqXIJv5svo4R4fhxsa3P4Z8/7gNYmv3MkS8G
         0qw0M2bPjAVyLzF28OtrupqcbVnNA2aQTszeYaF1SJjjy8vWQ8q5qBKQmXI+VNRipc6X
         y3eYZFk9j5EThRLmHNJeN+hddLDOCIheNFBlCW1VaG3ptMf0W6xEzAqS/+dRIfnYcv/6
         S8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OaNo3+m2t1WoDUpnIrKVbq1gRB1KaWUBA+5ABnBBlzQ=;
        fh=FAnMdHMSeY57VNW05iM1Wei+2RYKFxNEIAu/cjm77ig=;
        b=rOxVRU5Lmd5ia6BLNBeCUDX1qCww+gAigvgw4dOoGtyA+ogO7FQYCyvZjFew6geDQ5
         zAxTcLz5E2AY9nmHPUudkSUQoAqWRu0jkvJVfxxOVni5db2Lh9TDL76F2oETZ3yFAgyI
         bN7nBTgQlk+bVa6Cr0sTvca4qKfif1WcRS5xB1RERsBOqFNnNJ9Tx0O61G99gEYpdffk
         C5CKuMmONFeNcHWTh5oDqcGtOAK7Lb13oXbAXn/Pbl/J/DuxShAP9O6Y4TjHC5wMdkWO
         wYdhGXv/zlt1+ETmB7SFUOvpGMKq2rGGhH9qt9i5iTT9Hi8PtNcwyMuCNoLjZt9Isxds
         YK1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785800901; x=1786405701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OaNo3+m2t1WoDUpnIrKVbq1gRB1KaWUBA+5ABnBBlzQ=;
        b=bQdUe/6OU+Vuub/6vKvNogxO1Uzjou9eN2gC4h7OiNWMfGyr9nD3+inIb8bzsCwAY3
         kSpkJcjNNNKQslK2kflJmgb2zZJzFBdR7RQ9Is9S1iYZCnjKU8OUw3XNHXo0TRLycxsz
         Q29H8nrKGuIT+iYzvLNR8VtNJTqqRn6IeDVY1ON5ze3LQ2/2hso8LojqK9dG/QiFZP6o
         kFPG0VFosFXyg9kFa3xZArgY5mTy/jqEu0OfPYOl7/jJyiLDNDhAiALCH32QnR1y/FYk
         olncX5TvO3Y6yG97wMfCf66kUituvIaGHeF954S4yN2Ub/X5QyQUp7IM8F8zgdaHuAHE
         JvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800901; x=1786405701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OaNo3+m2t1WoDUpnIrKVbq1gRB1KaWUBA+5ABnBBlzQ=;
        b=fviK2BF44g69N6pfoChwmtQ8se+O9C/d+tMQSTZIpp/NPXky2QiShX0OJbkETRT9gK
         XG9+rhjqAxhp4TI/KUCP++tKZf+DQztL0/bSjCVXpqPb7PY/q+L5xsT9R3FsTGLbPEuS
         Bz6tE9ibt8RIKOTXZl/Cug1pbEr1TWZ3iFJwViYQzSh2pjaH9sGu5XyfUBoveyAAGd45
         Ey+E0eKUPbiudkhl53j0UPlXx+F09mwaKRn7538L0d38F+a7wydlV+M0k8l2fIV9GAzg
         4FGF7N3ITckRHmmXK2aZg4yTDLCUXkCMZVS/AI/TcmWLijFtWJ/8IbX56CSegRVDYRY5
         U5lA==
X-Forwarded-Encrypted: i=1; AHgh+RqYcsoQS9PeKjomMsYzHUyb97PLdm/DRaxmwBWV8v9/HB+fz2b6jblIce6tFIYw/wqSDHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxy2p7UdFQSDRpgLPYjv0/hx5uzGqHGpTfZ5lRBHuVk4bjMd4M
	R0nppzZke9pAtKlspDYIHYc8mOsIitY7UqseiAFUkbgt9B6WkGOdID5GUTmvNzSJSSuyVr6Qj8l
	TxVU4uHokdT6FFf9wMdbInKOoAjqVha5odWnLRVaN
X-Gm-Gg: AR+sD136/TxeDtoiXk25VE5OjvIBrfgsUWpNJMOQ4krpggRR6mxZn4PNCuY59aB8Pj6
	X0nVKsHD0kjxURZ+p2cQIYxEMctLatVTABY/iRuaC5L1Fo7Uv35294Fl4ImDZehY9uEpC6g/H9H
	yzAtdTujg8aZ5MUZ4IwgJyudB0mv2X4wULSrl7+H+iE0L035BTM6CZXMT2bQ6JJYkShF66Px2WM
	TwEAfM4cnSOajgMTr2ujFkpT+JBnCeC+QZbCXtZMP/x3ZQPGmL/MsrsGL0Qko6rJy7azMtbqb4S
	6c09E+hPraukgKWx13jlMngRkH19ld3w/rt2M9miGi+n
X-Received: by 2002:a05:6402:4585:b0:69a:df95:f1f8 with SMTP id
 4fb4d7f45d1cf-6a1240691femr31176a12.2.1785800900405; Mon, 03 Aug 2026
 16:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730182053.905335-1-yiranirenewang@gmail.com>
 <CALMp9eSJ__HL3jqaYOEn57cYER7M6NOWvge=CULcHjtqSH6+MQ@mail.gmail.com> <CAD26vaTMHGDho-APBMqTpk--JQGZxBnoC8SM6qEErcy-9Oqobg@mail.gmail.com>
In-Reply-To: <CAD26vaTMHGDho-APBMqTpk--JQGZxBnoC8SM6qEErcy-9Oqobg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 3 Aug 2026 16:48:07 -0700
X-Gm-Features: AUfX_mxy9BLBcfYXBgURzOodH6nspc7nXEvLgyejC2lmiAVm4xarzTAZB7XLFR4
Message-ID: <CALMp9eTtzvjCwR3wuWFxA61WtfaQJG6dvjxz4mjRf_CBRwrtYg@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH] x86: pci: Support unaligned register
 access in PCI config read/write
To: Irene Wang <yiranirenewang@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:39=E2=80=AFPM Irene Wang <yiranirenewang@gmail.co=
m> wrote:
> Since crossing DWORD boundaries is also not spec-compliant (PCI Local
> Bus Spec Section 6.1 requires registers to be naturally aligned), I'm
> thinking it makes sense to add an assertion here (e.g.,
> `assert((reg & 3) !=3D 3)`) to catch any invalid test cases added in the
> future. What do you think?

SGTM.
