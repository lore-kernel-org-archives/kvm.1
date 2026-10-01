Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11848642A
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890010; cv=pass; b=E6s2rVjnzuzPaEVWHXgpVEpG0TA/NXlrLCVV8puP5BCAbr7d79+79GwGgkAowdbvTNxjyatOewvsUOrA9k17lwFruCkjBMSNmL7hTuCCNeaBymZqfK4ebHVJ4vjf1aeEx0febUcjW9hisa1pxdwP8w8ZB4BpDrUscsE3Ij5A6cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890010; c=relaxed/simple;
	bh=5kJj/YjPUElaHpBdhAwAfjGyCSehJ25YvJQ9doQuCbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D24PPi0NwPpQykGFlQerd9TuCWGlpkVtv9qXI/xZdFp4agUbP7nyM/6aAUvENT/e/+oeFT/qioRUrDIb6+Fp8uiZgNyD7bYxqYgl3jasBMEhNJco6IMZoL2u4cQNc2wHyFah3bj50eJZ+B3Z5b/KyltUjZtYaG0c3s31hwxJogk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAhQsoxK; arc=pass smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAhQsoxK"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4e667873c38so2856186b6e.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 14:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790890008; cv=none;
        d=google.com; s=arc-20260327;
        b=Gx8YPgTcAe0fmWetgwoPrvEoARUlpbITeg6cggceKTsNZBFdpg11519jqnJcHv0MFL
         8tY4ePBwBic6IdbDB4GdiLMGjWCxJsAumvc5Gsr3cl7roRImX4+oMetOWs87o4JfvfqA
         diQhncRE/O16hJFQlGdSjV5surD6/0wEW0uqM0orFDPGP2C0evVqbaGJu+LhFa8L5Nfh
         0eJHmRRzgwi0oMO5qP+fvlf8Aofu1ypz5th1YB3CRd0zP3meYnKiBtGf3GpUEFvrxTU7
         2jkfmwWT2Ae8CzkXgGKeeDL7gD7k7P5ueUIiCtvIbwnbbhRO6pQzvQpGyEeOI/IKTB3n
         dgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EEJI5AmWq9kvDrvN7+gLxoAcIdEGS6uwkzuVRjJJ5qI=;
        fh=BF8MlNQRgtVi8ut1W9KcrfhCXg+ak4p1ebHR8z86kt4=;
        b=dcZPxU7Nmy2aZtURG+MBBPjkiWFlLmuue7X4N0LX0XEwoOaRl/tXNd3aC+RUuIv9R6
         znsApRgvj9FD/exXksyR9C55MBPhlERw6cKkC6N/eTYEd6+YijakB4uaHhgl/FHPcMAy
         EOJ2Lp41kvRIPkYjQsf+YiUZ22CM5R/ZlHP+0uL3QvQLUXfLWGLSd3AO0jEIvsdw3rmM
         2euu7G3meOqtSY1aoFQjuG3QfYLopt7rHnundoi+jW96/2IDc2ezSJOSqXsOFFPEHh+8
         tpHWWMwIMOPe3TmVAUp+RabcpbCJUv0VCMOs+oTIQsD+Lu74K7P1tsp3efia+v71T8pk
         lunA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790890008; x=1791494808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EEJI5AmWq9kvDrvN7+gLxoAcIdEGS6uwkzuVRjJJ5qI=;
        b=OAhQsoxKfV3Mo+gL1r3yRXef578BjWpFmTrEw/TUt4XZBEA2eqHq47mPBJ9ZS0qtKL
         JMfW3N/SEqEp57XkdANuKqNr/lWXtxxDpdOjrlHAfCrc25sitQovuFd78/Y4tgCicDlp
         0gIEOJ8DxKHnKFPs0EudO0KfIuJLCCyVvVNHZKRsQgZMQQ/27ca+LZsSY8qEnNttsTrO
         bNNzue0To7TBgqHgSLPpfeQ0Utsd6HZIZYm3Y+i3Ww+CRZmxI1Hpc36jezcsNKDLyOck
         ntTakoC8JRXtj+7tbfCpvapp7iAQIadmnX8T2LybfhZs5wKDOiXvHvRo7N6ZhXciqEOj
         uA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890008; x=1791494808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EEJI5AmWq9kvDrvN7+gLxoAcIdEGS6uwkzuVRjJJ5qI=;
        b=2n8HCyQP47o5kL14oEWHT/ejg5Oy6IGKnGue3Yea79aC2aKTWvGCvXFWoZABz6NVNI
         q9bfqJOWnkd8YtRzjLO0aOGrcFjqb7grRD+8b2i5mwFGjZ9YCDS/GIoOIFVfwLM90KYU
         jIEZa2A25rMM2CehNKUeKLOtS9XpBAVVSddrmSVucleIgpf4ckUtrth2XGJsSmYz3ha2
         NqREYY57n+wAEEz9IhRxRVz53+hATdCtVL21ObMv+n12b0NY4jWosY7udAt+XGQv38KX
         7hYQkIJN6JPo6+I8ZMoGebVUYqwC4lLKUDUZumJkpwz8engH/8KPBpQC4tFjgvVGYjs0
         +Cjw==
X-Forwarded-Encrypted: i=1; AKwUvBykYqxVJ0MH0m9QcaA609o/YowwFM1bwPy9mpjwaIxlWSJiNddzErjoYwkaPXFnBbPG8dg=@vger.kernel.org
X-Gm-Message-State: AFuF++nIsJlcLKQlZxRjjxJAKAQ+a3Mzm7PRCq+xxynTMaoPpGYYBR4Z
	LYRa2nzy6OIYrfCBsWsBSLNixxPSdvI4t5/fFHrZfkgPwzQxsJnSvMBYp8p/GmTdZnq70pmCSbN
	XhkFdUIW8u0FKPoPrrq1EDkeKVZHAuwn5e1WbW3gd
X-Gm-Gg: AYBFou2fMglYssnmC9g2tB2VrotvoU6BFE+160QTeYNA14dFq8Ldm7AzQHVuH0JoPHr
	tTxp5aggRqDtMAizDT26/2EO8vAAQ80/QXTL8fTMeRA42PQkr8zgoDY2gdODq5iQotVlec4Q3p0
	Vnakdvl79Egg2VDAA8QO1Pdd+4HPT13sj0VBE3KvCevQ38HAiH7gVPZ+pn5i5e1BZHccjWPsni3
	pqTCEWESXg0LGqDBgMHoDJo0oFTPtne5s8voaXT/oRXgupO6j+FIsCBPdCwcnZgndC4teeko9MC
	eqUu7ka4WqJqkWqlyichUpnmZFCPfQLPzE/yj/BMMSFwnKTJ3ek3E//WC4QZ56jNf9FiFR8y+Si
	AHxHels9R1O37PlWUa78qf4jBULmvmu4XcNdHpDCUGzjrQp3+Rw3tFgKWeBOjZC8+edttaCRMXJ
	GcXUEZrLXvcSPGrkmZLoayoMM=
X-Received: by 2002:a05:6808:f0a:b0:4d6:93c3:1aef with SMTP id
 5614622812f47-4f52b1b8219mr550043b6e.58.1790890007278; Thu, 01 Oct 2026
 14:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-4-seanjc@google.com>
In-Reply-To: <20261001202234.3794060-4-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 1 Oct 2026 14:26:08 -0700
X-Gm-Features: AclHuK_jD8_Az1NWQmBSP6uJu5bELGSPzh6zWF2qzLw4EN-s4elX5ThB-3dDs8g
Message-ID: <CADrL8HUeOETayLAeutN+8UHq+2eg_nBWf-PPMMsfoLei0HY04A@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] KVM: x86: Unmap VMAs for KVM-internal memslots
 when the memslot is freed
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:26=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Unmap KVM-created VMAs for KVM-internal memslots when the associated
> memslot is freed instead of unmapping via x86's internal API.  This will
> allow deleting/freeing all memslots before kvm_arch_destroy_vm() without
> leaking VMAs, and in general is a net positive as it makes it far less
> likely that KVM will leak VMAs, e.g. in the unlikely scenario some other
> flow deletes KVM-internal memslots without going through
> __x86_set_memory_region().
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

LGTM; this code is so much better. Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>
