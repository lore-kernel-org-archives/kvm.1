Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B701A683A
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688815; cv=pass; b=WF3hXD3ADEsNU9Y01eLIrK43THNfIHO3sPt2DIp6q4whnRlo6Gx1nUTh6y5taEi0gjcftUsqAfvmTVVtHZH0c0tiUJNrzgPNoqzlmFjei+ceILXPAosJvaRA5TLaJ3E325SiBwOKMBGLUyNNOQjsAueZXHzOHKy/aBJHLb9O/KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688815; c=relaxed/simple;
	bh=Fey+jTx0vHRsYaHeJ1TZrstn1canobwyLWL0ZAO7Tqw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MedEVRqraJ2NE3x6GaI4ljDnSZfjMCPW4F8cZ3qe2Sir9aPwSQuJvvCzqewJQ7yKSmjuddXIGL9aMb8X0Jw5htbcwfbElt+DfWXYSU7O8CqKEljvufRGb/rwClxtXGVwPw5tACiMjvbIdadS+G2kZ75YGq02HgrDBG4WSYWhvok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CltL/6zM; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CltL/6zM"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so2436817a12.3
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 12:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780688812; cv=none;
        d=google.com; s=arc-20240605;
        b=C56Jj4mLJ9eMUoFZ7FnZedCEgeVgDGbX8Zgko9m7D5VNnLAvIsaflWZd/yEJPDCCz7
         DoiN8FEUKWyN6JBwiyt6iZcec9mQARgYKgjil1KcBIQOzWWUH/Eo4pYf5/gPS9iXCVhB
         UPRKf200H45j22S9j6kJW9SVYOczWJl7EtFqb0dKXZcPHvhnKVh13fqZT4QpUiLWZ08I
         II2d25P5b5tTkPJUnreFWMCwLaKkG3vENXoSsdo4mn9o9ppYp/m3145RtH3g1TqX6D+6
         WhBRQyifCeT6tt/3RBeAGq2KhP0s8Zg5YtnYTxX0ywaxFwhA46bXrSXYO6IduvXyuPaC
         Hieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:dkim-signature;
        bh=Fey+jTx0vHRsYaHeJ1TZrstn1canobwyLWL0ZAO7Tqw=;
        fh=3x3ZdJ/Qd0GB/FmaJZ/ISLlT5X/H48C9HHO34rEPYNY=;
        b=FnEoYWhDQk5YqQkMa4Btw46+R9QS+qXinX8Sr0jEIoEj82Ryl/MljzBJAuXvTgIHtw
         2gGKHzelkQVYaTeu+d6inNqAVindDzA+Hghr/pa42Pl03U+7XiN6jdw41buhldSpvg2X
         V9kcSsib6y3wBvgZwXNmaY5hGkw6RmpHCrIhpv5pdPD89uOQ9dI5ec72bvPkuMlxo1dV
         ioxfFXNrE3GRUbhuR/VUxhy+ycUXV4TzW/USACQFdfE+jtQaKm7Y8enCgJ5ysaiZDIH5
         hCry8YpbwgIL4ZzW2nsMyu8ep+IPTKNe2VRv3u+ZC4Yn+nN/GFUCHeP2uCSEZQ9QMaKp
         mG9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780688812; x=1781293612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fey+jTx0vHRsYaHeJ1TZrstn1canobwyLWL0ZAO7Tqw=;
        b=CltL/6zM0RybQ8z0JuYmBB3NrNhJ5vXfGUfTuZzfZeuniQtuOpujI+YxKXQKDQFnZK
         o5naIo3ZX4xEiXwseRIleg0tS/BwXP64RXHlu94gJSYHlMRZoEtc7/AEp+eEWUbw3y1Z
         P3T14enrk30e2lyGrLtnrqJ0zOxYr1pX6Oc2ubK5taEQJWQcqj+tSSvXpNG5R6w8F7a+
         bnudwb18aXRd7+YxfZTA3XaHsYl159/4Ns452+ril/b29/YjBrKUAqIEGDmc1L251m5v
         sIEp31djagtX1xaZz6MbEDw6S9JdP5xiPjW1rhoq3sM9Fq71ldJ66mqTkODjntvxANLm
         l4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780688812; x=1781293612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fey+jTx0vHRsYaHeJ1TZrstn1canobwyLWL0ZAO7Tqw=;
        b=fQ5PCLYapXny/6AAgV9oReYvGodTNNifXWfqaYqNOt2qgtW2E5/L6hThAqGlK9czKK
         8bLy5qEKuKTYfQbW76aU1vAzx5OjdoY38SQg58jIHeDEvoeqaCmhjukJG9fTkZlkERtc
         TBD259csULALEmyQYVtvwkY4E/NmqJKkdP7H77yIBkBoz28ngysJOSSgI2W71vBlInhH
         8sjNmhv820YTc4b8MF6dO3AdK89/T3NnZA4obWCpMWXmR43q9aFfuf+76uQ+xf2b73Q6
         QpuNTWkijSKIcuea459DUGruThAuIaoTlEsE61wTcIr4xPho5cMX3L4o92VuQi/I3SOx
         wOlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uBRSPn1rqyABlGeNwJcXT4stXpaOwtuItQB+x8k2BPp5/NqVg1JDiBMtQUbjbmwfDWOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmR/Mt7GITWo5mrlq4WbWcu1GkHnfl7HZHNO+WnxWZO5IivJml
	KV9+Ns6wcmykROLCDPQ2IUQ00HI4xuSBld9tM4Sd3nUFchnDw2hQa4cc9tUAqdQ3U06iAdHEMPn
	Qub9YiQ9Y4C9Q50TN6OVXqkUY031xQd4=
X-Gm-Gg: Acq92OHNvnfHi109O1onFVtSamvRAwjVSpRwqAyLYZnzfNvj/SNtNXzCFb0Uh4LrM1X
	kMW570AqbD6JGq0CeFek8B9Y4gvsHQHJdY0MlgbM4+S1uRNG0bc8tORYECkFasNYtXyJM5l/ZHQ
	VnQaqZsAeS/02Q1UicdN0FJNN4it5ptrYsgZVaRXsfvZhPCQAYDLvjqraXWC5N4cSuxldoSePby
	5CLIufLrnIXsEhh3yxn54KRER4EPbsvRaq1BVjnFnXUQOiNCKmvYzIJBKRGZXr0FIpgq2xYLPmZ
	RbS4rEsy0BhNxr6xSIqAnSQntotWDvZnIrHXjmL4bypcaPkdtgXESjgV+RQKlw==
X-Received: by 2002:a05:6402:1590:b0:68b:117b:2158 with SMTP id
 4fb4d7f45d1cf-68fa525bc86mr2480948a12.24.1780688811737; Fri, 05 Jun 2026
 12:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Fri, 5 Jun 2026 12:46:40 -0700
X-Gm-Features: AVVi8CeVQK4jkY4O6NY__I2P8vLSAnISPEqoKu0UP4epKGytmus3mYzWCZU7TTM
Message-ID: <CAKSQd8VbXJ8pX_igweSAKv8qmP5vOpybaoTn5fuyFf_cXNyo8g@mail.gmail.com>
Subject: Re: Re: [PATCH v2 2/6] KVM: x86: Prioritize DR7.GD #DB over #GP due
 to illegal DR6/7 value
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [DR7.GD gets cleared]

Another crucial tidbit: the clearing happens at the
beginning of the #DB delivery attempt. So even if
something goes wrong during that attempt, you'll
end up in some other handler... with GD=3D0.

See https://www.sandpile.org/x86/debug.htm for
a 22 year old writeup, which =E2=80=93 thanks to a bunch
of poking by Andy =E2=80=93 finally got published. Back in
the old days, #DB implementations... well, let me
put it this way... they left a lot to be desired.

--
C.
