Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA4E3E716D
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963818; cv=pass; b=BTohUt5/eRjuhEtyqHVDhja5na5TR62R49LbIVBKjiInN+raINpmfq9i9VY6YD2dGPCjg23wiV94Kaqy4tyafWklqW7UNcdOvhjKzdJaCeLGzMV4HvAo47DUkufcBqJKr+88Hkj/41GlKxJBpgds+fnkg04xyfvzdpt1Dl1nBBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963818; c=relaxed/simple;
	bh=VTxRX+AGKykbXJwtykp/HSXepAAcrtHUIjosixpxHhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cP+2AcfG/CgCgA2onW27HQ3oKZCd5ryFD53hFRUqVEn8LLhmmIo65z7rNCG67ziCPLGzf0l4dVgnVOHSOfSn2+HXFMWo+4hkhsWqvPsUuVECkr36D24U6fACQqqe7gvx2cOfpCN5ceOAnpFDUmZkcgzP2ktOpb8J+2rZCPSOhCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtJNmnmH; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtJNmnmH"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a12c19affeso941061e87.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 16:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773963813; cv=none;
        d=google.com; s=arc-20240605;
        b=lnygr77+SF2XRCq/9WDtlJFehy8zW2s/QTgcdAKpKjJhzhmdQCTT3R2LQb8G/BOXRr
         mNfNWLt5gknm2jpbxVIpa5wrNXElTU2M48ZOYAQfSSqpMUhmwf1rr9e8chQ33syizq4L
         47uHG9h5W7MkRJVIryBESv1A6ThZ66vsxRdTghXCQecrL4Vf2Ese2gRnlPzWc6/oiIai
         NYO+o5jJJzKLkNs6G1jXR78iv4dzq83HMal6JFYQaG50cmXaX9BsMjuVor7CxM0dGusR
         jG0wQXTTsY6lUIXhzVWIe2mR3haqcvOHwExtLmVkd5JOsCvitvibAhB1PXtnh1nzCdFF
         9UwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VTxRX+AGKykbXJwtykp/HSXepAAcrtHUIjosixpxHhE=;
        fh=AH8bwfOowInxAlCcS51bZV3duH5RuDol8zCns0gnv90=;
        b=Jc1k6E4glKO535980A0c90AmyFyX5Xb1zvNf7cytpeAX+j8N4AhbXVXViKDj+bXo4g
         kQ+AZawP8+fqDuqFRWV3FGRVzzFR31chRDb327fRPRFdlw9Ee6gezny3nwWhhEbASYX1
         Nh6NW6oo86+L6L92LCiAPzg6WHWqiOaLiQmIyMdgqizLR7us2NIMZp14vwaIn539tx7U
         lXyMjhwHqPh6G1JpvgEhQPd9A38d6q2vP6Aw9LB6VHrNcmThRQLLeQnENv3lnazLM2Li
         j+QojzF6mu9R8pvVMTzRImAfnvEwrRPowG/jwbOa1kOZUH5WFUZf78olbR1Iq5xazRXN
         zS/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773963813; x=1774568613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTxRX+AGKykbXJwtykp/HSXepAAcrtHUIjosixpxHhE=;
        b=dtJNmnmHdJSxi0MXxOM6idGO5cPE5KFRQgi8YrMddyJO9PosNcOokqOEU6fphPzEkv
         h+uHSSsl/Oj6KkuuHRz3K+g7uEK3I/Dbw8aQsUEstbSh3rSN4Xx/aj5t+DnFcV4CiJPl
         OSCI/H884V4CrzRv8FMiDDSLXOvhXbE017FMt+7HBjKTZIS7dJZmJyB7DAOcf67w7TSu
         vODaY2t0pNxoWMqgAb479neQLfdX+Mw8Ot6kSe2mpAFhLG5I9RRd5C5KY+4czGjpJX9b
         kASzkM/jJT33EnRJEWLCIWE4LlO3m9GNDy3ukoo6UU+ACdKgB4o96xlhX5WVf0dLftYd
         IrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773963813; x=1774568613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTxRX+AGKykbXJwtykp/HSXepAAcrtHUIjosixpxHhE=;
        b=ARSvxE2d6zcv5J6oP05sXlmZdwqo3GdbJ0iDRAS3X9BUqlFNoeE6xRjjyO9jbkvNhW
         TfqBKrA2FNySTnSjLryCWfZYDbRSaVpLx1vIAa67RYGiXg+myJQyAAyIO5KEcgV5toUO
         P0htUtLVQvFrIbCwSaP6aIwHKLZiCc9KrFew4RVMVzkcSvuaE6oDo8a5RIHnd5deJoCf
         FaIh+18aoNPvS5UqfjyUQYrnLO4AA4VSfzvM6NRjPCwhsnQi0ihamXkVV+oS11P0isG/
         1HD046gu62O+MDw2vCNuALg8emXCDhqx83qJ7Eag9rNfy96r803bMS9sRQqlLu52f9h9
         UaGw==
X-Forwarded-Encrypted: i=1; AJvYcCXZCEJdGaWYUIZU7CdRcdP4LOTM2hbxLN8DWrI0oDiEGi5939Eayv2mp+PgGmJWclCU954=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZtdq7yMiIaKZZA49D4LIqaHYDwKpW0SrnwSOmSi0R1IuPEWq
	qPpFdTNnhrR2B9FBCdZ88tTpYWM5SFNeNRI66uwScFzJsjFl76ihL7D90c9rky8Cx8PbtQ8UAdR
	GdkazJNeUY6jAfo0Pakyg1E8+I03lYR4JxNY6vxLw
X-Gm-Gg: ATEYQzxQ1gQzPxbvccjRSSGQR2ohUydDVa2ySslKCfr9Q8pKbS8A8LTIX6Ph9Yjt2vi
	VYiXgbzm9NwsHOqJAspI3e9D0ieg3H7n0kfD3ZSwoYy+mbsFrSy9y1lHinKmQ25tirtpCMx+1wq
	oykQYqyac0XM5HsW0qekHV5cxFKGVbGpHIgg1JPSzBALLJFqKidqtVUPXuizvcxXJn1wNzeZAWt
	mm5WOn3LFOMUxsdbA1DfTe0z0XOjBEJArUFKc1fZbhl1COm/YosecZ8osVFjnwV3Ds8xGI3edgz
	WU30ROebOWaYGKBr5fs=
X-Received: by 2002:a05:6512:460e:b0:5a1:2e7b:d885 with SMTP id
 2adb3069b0e04-5a27de5dc98mr1324588e87.25.1773963813029; Thu, 19 Mar 2026
 16:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319-vfio-selftests-aarch64-v2-1-bb2621c24dc4@fb.com>
In-Reply-To: <20260319-vfio-selftests-aarch64-v2-1-bb2621c24dc4@fb.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 19 Mar 2026 16:43:05 -0700
X-Gm-Features: AaiRm534MfCLjFwMGGENHbU_DKBjVumsiYOQM8YxxMK1Pas88mVouCmO-lmvCvE
Message-ID: <CALzav=dUWartDcyoS09_mr-vziBeEDhKa4_Lfb8R_2wFcw9ULA@mail.gmail.com>
Subject: Re: [PATCH v2] vfio: selftests: Build tests on aarch64
To: Ted Logan <tedlogan@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Evans <mattev@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 3:59=E2=80=AFPM Ted Logan <tedlogan@fb.com> wrote:
>
> Fix vfio selftests on aarch64, allowing native builds on aarch64 hosts.
>
> Reported-by: Matt Evans <mattev@meta.com>
> Closes: https://lore.kernel.org/all/e51b4ff2-13c4-47d4-b781-3dcbd740d274@=
meta.com/
> Fixes: a55d4bbbe644 ("vfio: selftests: only build tests on arm64 and x86_=
64")
> Signed-off-by: Ted Logan <tedlogan@fb.com>

Reviewed-by: David Matlack <dmatlack@google.com>
