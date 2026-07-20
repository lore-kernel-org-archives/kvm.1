Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207EF2D6E6C
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784588867; cv=pass; b=F3W1P7AQ3RYqtmkO3ExO9GcA3YNI/R8MY8TT29IXg93mKQwRmfSlxYXrJAcNaqQCDi9iq/JWfJm6kCcbj+aVRibDHoeZAvQY4iCG8kht8ClGNmFQdI2yec2RyxWSLiCNnDBh+vV12w2e8Zow63DjW9RgcolgWVPVcTKUTZ5IE9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784588867; c=relaxed/simple;
	bh=dVP96a31HH+L3qenIca/9Kz266g0/NYzjWKBfIKyZ3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QXM/L7cSXcdGmxSoeGEVC6pC3NUe8TQTs1zpH/uNKDDVTQKXBhIBOsVv//Jmv5UQ8lLUpf6wFKNBoy4FwAcfE2y3uAG4k4pzvgsiIbmgdOYvcrUp03LSzNjbD1juj4ag+8FDDSjduOGZiur0dXbG+NISbe3EaHmsntQD/vog4jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gG9EFjER; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gG9EFjER"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so41350a12.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 16:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784588864; cv=none;
        d=google.com; s=arc-20260327;
        b=MQTiatauo54DFRsrGbPNvIbjta4L/9BHV9OqJwmUeWGhUIE5WApsiX3pTbAzflS4wz
         ulHSKw8YeR1mDpDveQ4mKrkr0idSiRyiqBfmsOvf1VWJydkNfK4VprJkIl3xYkW1CJkS
         sR6z4DYXPcGecSfe+7gR9F6prJad5tZO0NtrPYq5JELLErLyXQmjufizxNVJx5jjXhJE
         RdgByY7UzoQILfukDKxYDmfZLQkXdgNlCwj0yoVF4657J6plUuwOun5e1VlvEAmnzFuy
         dM7mfSc8uzgfdd/rk76yymrJzcxBfbeevzoItBxjz2n1x2+6+krtfSxuTuKVWHQ1DnTT
         SqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dVP96a31HH+L3qenIca/9Kz266g0/NYzjWKBfIKyZ3A=;
        fh=TnVGbcWWn6m+i7g4qunVkKNgSs8eSR2bJC811Edi6Pk=;
        b=C8y7AWpTIu7z3lkwRL6uC1gWaYb19b52MqPuRuhDKxYXV5sDkJHg4duO01FIlzoz0x
         IwDaLYyurUhjkvJGglQgBz1RLEPqP98i8D6TAWTpfmwmDiN/8t3tEvZGC4RmLlgKm7dx
         hyKlC8gdHfYkleAQSeVGNpsU0+AQe3dA3tmIErnBze/fpjapcP2Z/3rV4sA+LfbzX1Zm
         AXCiQYW744d4aBCWlQvM4ywpcJlMrpnzrCv60psSNqGyACMT4jXIyRKYIR87vN2T6UQ4
         1Yel0yERdyYyXXCp0vVxpd2A6DM/INbcab77lFDXu04WNc0mS+9voSiui+I8w4C8AQF6
         3kgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784588864; x=1785193664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dVP96a31HH+L3qenIca/9Kz266g0/NYzjWKBfIKyZ3A=;
        b=gG9EFjERcHwZb6t4iOjKlJ/ZoAO6MEK1OAc6bzQC9djXsnM5Pbd/zzvgB3FJATau6J
         FkDXQUdCGedX9gQcJazETSHI13ViH/0PzwlsSwX8QBqjiUg/ar6yI3Eucai9HR5uEN7l
         ZQ7BYKyQoEq0DOScbiGwOW9T1lAul8jfgPgpcrFtADrYUAG3OA3aN+kMMxxovD2nksP7
         UBHAMk0efsho7J4rMySW5fHcImOid30oCf9j9qVrDEItXodiP773V0gnVPOvDnKMyECt
         m8IqnuiCDs5t0V3x/CcpKMWitWynnj61+smr/34AlQpX5LD3TmXykyFhxKso2K8/lxmG
         cw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784588864; x=1785193664;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dVP96a31HH+L3qenIca/9Kz266g0/NYzjWKBfIKyZ3A=;
        b=EGqwWlLYqefvl9wo0Z7+68VExG2tWUaAgWZtEQScyu1D3UrfXf4cDxjKFqu+1xFrFU
         qxPFu6iREiFv23+IbarO6rNdqu4nUWv/8im8Xr956A3/6wZ8vYpRPZxj6WGPezVN0FI2
         nUfHmakjNGxFmdKFh+7CKPr5AJDX1/YWB9jufSD43HlERDRjV5Ipc/R6x5Ojc8eqMIof
         wTnp36oZnfaghizUPJ0ETigT3IkCsOxHlHkqigF8oLKJZ2l3wbYhSdPffDnw3OQvxQbm
         4NkhJSj+t+yFdSm3x4ZjoeuwL10LVGrJVUpSovf17iXdNRlswesHydD1+xz9siJ6wmes
         PulQ==
X-Forwarded-Encrypted: i=1; AHgh+RoiqdeZY4ITFbZ2QCiTZQEVX89ZFCPgUtD+eAMEEGgYDN9oS2V10w5Hc3+GUgpGPkreiNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynuAfcnYMbeUY7Qraf9LDxDwWb/DuRQQNTKVwSIIr+dgnMNATt
	XESwO6rIEg3ihL4oj04FziSsdwj9OJ+V8IkdhO3n4fHiqPMN1F+gVv9oCKHO0xi/cZbro2qAL3/
	a4KnGXQJGxS3ZhV7SamRCuCqS6tceeYQeK3bpuCZd
X-Gm-Gg: AfdE7cl5VwPtO7sG7dQtJc1+TrC1X5jV/JH221chVxrCYVMdNFfpEnW/eLDSVABOagO
	+TuwfOOev6ASx9G74l0QmKvZ6/LbzE8+dVsCm18Xo3ht7bvGqG24c97FwLAXSTtFN1rQ3zd89Jt
	bYcRTVFA/8k/5XhEBrU+hRjN+nohJqGFA+pAPZ93BxICUbXjWeLX6cEo0xYxLQI8FT3QpzgRDVr
	5qEzSQq1BBRHH2O8zXc4hs7JG06sDLRduWTJ9Piz+3JU9nPdkfQUn3QuaLJ8w==
X-Received: by 2002:a05:6402:a28b:10b0:69c:cf5e:a504 with SMTP id
 4fb4d7f45d1cf-69ef50e6e08mr46989a12.8.1784588863907; Mon, 20 Jul 2026
 16:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619152006.3684428-1-jmattson@google.com> <CALMp9eRRMga2zMrAK8-bbxcjWwyW-W+F1KE5bJqXLQN6eR8bog@mail.gmail.com>
In-Reply-To: <CALMp9eRRMga2zMrAK8-bbxcjWwyW-W+F1KE5bJqXLQN6eR8bog@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 20 Jul 2026 16:07:31 -0700
X-Gm-Features: AUfX_mx5sWM8UaqsddBRxwiAIF6VxeXOCm06DuBr1D-f-pahQefmjSh4l0QS8Lw
Message-ID: <CALMp9eSjp6r6WwfOt4PPzVZ+QZmfbSHZzn-m0kRYToy8kK9MjA@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH 0/5] x86/apic: PV IPI robustness and
 subtest selection
To: pbonzini@redhat.com, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 2:54=E2=80=AFPM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Fri, Jun 19, 2026 at 8:20=E2=80=AFAM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > This series improves the robustness of the APIC test suite, introduces
> > generic subtest selection, and adds a new test case for a PV IPI bounda=
ry
> > condition.
>
> Ping.

Adding Thomas Huth.
